#!/bin/bash

set -eux

workdir="${WORK_DIR}"
dockerfile="${DOCKER_FILE_LOCATION}"
distributionfile="${DISTRIBUTION_FILE_LOCATION}"
logs="${workdir}/logs"
dockerbuilddir="${workdir}/docker-build"

mkdir -p ${workdir}

mkdir -p ${dockerbuilddir}

cp ${dockerfile} ${distributionfile} ${dockerbuilddir}/

image_id=$(docker build --rm -q=false ${dockerbuilddir} | grep "Successfully built" | cut -d " " -f 3)
echo ${image_id} > ${workdir}/docker_image.id

rm -rf ${dockerbuilddir}

catalina_out="catalina.$(date +%Y-%m-%d).log"

if [[ "$(uname)" == "Darwin" ]] ; then
    logs='/tmp/docker-logs'
    grepcommand="boot2docker ssh grep -q 'INFO: Server startup' ${logs}/${catalina_out}"
else
    mkdir -p ${logs}
    grepcommand="grep -q 'INFO: Server startup' ${logs}/${catalina_out}"
fi

container_id=$(docker run -d -v ${logs}:/var/log/tomcat6 ${image_id})
echo ${container_id} > ${workdir}/docker_container.id

echo -n "Waiting for tomcat to finish startup..."

# Give Tomcat some time to wake up...
while ! ${grepcommand} ; do
    sleep 5
    echo -n "."
done

echo -n "done"
