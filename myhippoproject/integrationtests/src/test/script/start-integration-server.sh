#!/bin/bash

if [[ ${BOOT_2_DOCKER_HOST_IP} ]] ; then
    echo "Boot2Docker specified, this will work if you use the new boot2docker-cli VM.."
    boot2docker='yes'
    docker_run_args='-P'
else
    boot2docker=''
    docker_run_args=''
fi

set -eu

work_dir="${WORK_DIR}"
docker_file="${DOCKER_FILE_LOCATION}"
distribution_file="${DISTRIBUTION_FILE_LOCATION}"
docker_build_dir="${work_dir}/docker-build"

mkdir -p ${work_dir}

mkdir -p ${docker_build_dir}

cp ${docker_file} ${distribution_file} ${docker_build_dir}/

image_id=$(docker build --rm -q=false ${docker_build_dir} | grep "Successfully built" | cut -d " " -f 3)
echo ${image_id} > ${work_dir}/docker_image.id

rm -rf ${docker_build_dir}

catalina_out='/var/log/tomcat6/catalina.*.log'

container_id=$(docker run ${docker_run_args} -d ${image_id})
echo ${container_id} > ${work_dir}/docker_container.id

echo -n "Waiting for tomcat to finish startup..."

sleep 5

# Give Tomcat some time to wake up...
while ! docker run --rm --volumes-from ${container_id} busybox /bin/sh -c "grep -i -q 'INFO: Server startup in' ${catalina_out}" ; do
    echo -n "."
    sleep 5
done

echo -n "done"

rm -f ${work_dir}/docker_container_hosts.properties

if [[ ${boot2docker} ]] ; then
    sut_ip=${BOOT_2_DOCKER_HOST_IP}
    template='{{ range $key, $value := .NetworkSettings.Ports }}{{ $key }}='"${BOOT_2_DOCKER_HOST_IP}:"'{{ (index $value 0).HostPort }} {{ end }}'
    tomcat_host_port=$(docker inspect --format="${template}" ${container_id})
    for line in ${tomcat_host_port} ; do
        echo "${line}" >> ${work_dir}/docker_container_hosts.properties
    done
else
    container_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' ${container_id})
    exposed_ports=$(docker inspect --format '{{ range $key, $value := .Config.ExposedPorts }}{{ $key }} {{end}}' ${container_id})
    for port in ${exposed_ports} ; do
        split=(${port//\// })
        echo "${port}=${container_ip}:${split}" >> ${work_dir}/docker_container_hosts.properties
    done
fi