#!/bin/bash

CONTAINER_NAME=cyber-dojo-katas-DATA-CONTAINER
IMAGE_NAME=alpine
FROM_DIR=/usr/src/cyber-dojo/katas

docker run \
  --rm \
  --volumes-from ${CONTAINER_NAME} \
  --volume $(pwd):/backup \
  ${IMAGE_NAME} \
  tar czvf /backup/backup.tar.gz ${FROM_DIR}
