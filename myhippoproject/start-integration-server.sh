#!/bin/bash

set -eu

workdir=${WORK_DIR}
dockerfile=${DOCKER_FILE_LOCATION}
logs=${workdir}/logs

mkdir -p ${workdir}

image_id=$(docker build --rm -q=false ${dockerfile} | grep "Successfully built" | cut -d " " -f 3)
echo ${image_id} > ${workdir}/docker_image.id

mkdir -p ${logs}

container_id=$(docker run -d -v ${logs}:/var/log/tomcat6 ${image_id})
echo ${container_id} > ${workdir}/docker_container.id

echo -n "Waiting for tomcat to finish startup..."

catalina_out="${logs}/catalina.$(date +%Y-%m-%d).log"

# Give Tomcat some time to wake up...
while ! grep -q 'INFO: Server startup' ${catalina_out} ; do
    sleep 5
    echo -n "."
done

echo -n "done"
