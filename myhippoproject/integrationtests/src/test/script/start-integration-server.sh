#!/bin/bash

if [[ ${BOOT_2_DOCKER_HOST_IP} ]] ; then
    echo "Boot2Docker specified, this will work if you use the new boot2docker-cli VM.."
    boot2docker='yes'
    docker_run_args='-p 8080'
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

catalina_out="/var/log/tomcat6/catalina.$(date +%Y-%m-%d).log"

container_id=$(docker run ${docker_run_args} -d ${image_id})
echo ${container_id} > ${work_dir}/docker_container.id

container_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' ${container_id})

echo -n "Waiting for tomcat to finish startup..."

# Give Tomcat some time to wake up...
while ! docker run --rm --volumes-from ${container_id} busybox grep -i -q 'INFO: Server startup in' ${catalina_out} ; do
    sleep 5
    echo -n "."
done

echo -n "done"

if [[ ${boot2docker} ]] ; then
    # This Go template will break if we end up exposing more than one port, but by then this should be ported to Java
    # code already (famous last words...)
    tomcat_port=$(docker inspect --format '{{ range .NetworkSettings.Ports }}{{ range . }}{{ .HostPort }}{{end}}{{end}}' ${container_id})
    tomcat_host_port="${BOOT_2_DOCKER_HOST_IP}:${tomcat_port}"
else
    tomcat_host_port="${container_ip}:8080"
fi

echo ${tomcat_host_port} > ${work_dir}/docker_container.ip