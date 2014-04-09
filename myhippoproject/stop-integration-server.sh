#!/bin/bash

set -eu

workdir=${WORK_DIR}
container_id_file=${workdir}/docker_container.id
image_id_file=${workdir}/docker_image.id

if [[ -e ${container_id_file} ]] ; then
  container_id=$(cat ${container_id_file})
  docker kill ${container_id}
  docker rm ${container_id}
fi

if [[ -e ${image_id_file} ]] ; then
  image_id=$(cat ${image_id_file})
  docker rmi ${image_id}
fi
