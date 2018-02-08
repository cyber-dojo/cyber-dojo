#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. ${MY_DIR}/env-var-repos.sh

for repo in ${CYBER_DOJO_REPOS[@]}; do
  echo '------------------------------------------------'
  echo "BUILDING ${repo}"
  echo '------------------------------------------------'
  cd ${MY_DIR}/../../${repo} # [1]
  ./sh/build_docker_images.sh
done

# [1] docker-compose docs claim you can specify
# a .env file in the same dir as docker-compose.yml
# and it will be found. Alas not...
# https://github.com/docker/compose/issues/3381
# so I'm explicitly cd'ing.

