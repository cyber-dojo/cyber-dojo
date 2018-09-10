#!/bin/sh
set -e

# If you are on DockerToolbox remember to run this from the default VM
# $ docker-machine ssh default
#
# You need sufficient rights to /persistent-disk/ to run this script.
# You can switch to the root user by running
# $ sudo -i

extract_katas_from_data_container()
{
  local CONTAINER_NAME=cyber-dojo-katas-DATA-CONTAINER
  local IMAGE_NAME=alpine
  local FROM_DIR=/usr/src/cyber-dojo/katas

  docker run \
    --rm \
    --volumes-from ${CONTAINER_NAME} \
    --volume /tmp:/backup \
    ${IMAGE_NAME} \
    tar czf /backup/backup.tar.gz ${FROM_DIR}
}

untar_katas_tgz_to_tmp()
{
  tar -C /tmp -xf /tmp/backup.tar.gz
}

move_unzipped_katas_from_tmp_to_persistent_disk()
{
  mv /tmp/usr/src/cyber-dojo/katas /persistent-disk/katas
}

change_ownership_of_persistent_disk_katas()
{
  chown -R 19661:19661 /persistent-disk/katas
}

#- - - - - - - - - - - - - - - - -

if [ ! -d /persistent-disk ]; then
  echo "/persistent-disk directory does not exist"
  exit 1
fi

extract_katas_from_data_container
untar_katas_tgz_to_tmp
move_unzipped_katas_from_tmp_to_persistent_disk
change_ownership_of_persistent_disk_katas
ls -al /persistent-disk
