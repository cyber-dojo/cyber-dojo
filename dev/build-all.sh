#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. ${MY_DIR}/env-var-repos.sh

for repo in ${CYBER_DOJO_REPOS[@]}; do
  echo '------------------------------------------------'
  cd ${MY_DIR}/../../${repo}
  pwd
  ls -al
  ls -al sh
  ./sh/build_docker_images.sh
done
