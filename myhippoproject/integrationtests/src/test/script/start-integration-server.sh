#!/bin/bash

set -eu

workdir="${WORK_DIR}"
dockerfile="${DOCKER_FILE_LOCATION}"
distributionfile="${DISTRIBUTION_FILE_LOCATION}"
dockerbuilddir="${workdir}/docker-build"

mkdir -p ${workdir}

mkdir -p ${dockerbuilddir}

cp ${dockerfile} ${distributionfile} ${dockerbuilddir}/

image_id=$(docker build --rm -q=false ${dockerbuilddir} | grep "Successfully built" | cut -d " " -f 3)
echo ${image_id} > ${workdir}/docker_image.id

rm -rf ${dockerbuilddir}

catalina_out="/var/log/tomcat6/catalina.$(date +%Y-%m-%d).log"

container_id=$(docker run -d ${image_id})
echo ${container_id} > ${workdir}/docker_container.id

container_ip=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' ${container_id})
echo ${container_ip} > ${workdir}/docker_container.ip

echo -n "Waiting for tomcat to finish startup..."

# Give Tomcat some time to wake up...
while ! docker run --rm --volumes-from ${container_id} busybox grep -i -q 'INFO: Server startup in' ${catalina_out} ; do
    sleep 5
    echo -n "."
done

echo -n "done"
