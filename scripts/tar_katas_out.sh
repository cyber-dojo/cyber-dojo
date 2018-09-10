#!/bin/sh
set -e

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# If you are on DockerToolbox remember to run this from the default VM
# $ docker-machine ssh default
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# You need sufficient rights to /persistent-disk/ to run this script.
# You can switch to the root user by running
# $ sudo -i
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Intermediate filename. Can be changed
readonly TGZ_FILENAME=katas-backup.tar.gz

# Name of the directory that the storer service expects
# to volume-mount. Cannot be changed.
readonly TO_DIR=/persistent-dir

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
    tar czf /backup/${TGZ_FILENAME} ${FROM_DIR}
}

untar_katas_tgz_to_tmp()
{
  tar -C /tmp -xf /tmp/${TGZ_FILENAME}
  rm /tmp/${TGZ_FILENAME}
}

move_unzipped_katas_from_tmp_to_persistent_dir()
{
  mv /tmp/usr/src/cyber-dojo/katas ${TO_DIR}/katas
}

change_ownership_of_persistent_dir_katas()
{
  chown -R 19661:19661 ${TO_DIR}/katas
}

#- - - - - - - - - - - - - - - - -

if [ ! -d ${TO_DIR} ]; then
  echo "${TO_DIR} directory does not exist"
  exit 1
fi

extract_katas_from_data_container
untar_katas_tgz_to_tmp
move_unzipped_katas_from_tmp_to_persistent_dir
change_ownership_of_persistent_dir_katas
ls -al ${TO_DIR}
