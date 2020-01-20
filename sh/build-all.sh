#!/bin/bash -Eeu

exit 0 # current not used

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"

echo 'Building and testing...'
source ${MY_DIR}/env-var-repos.sh
for repo in ${CYBER_DOJO_REPOS[@]}; do
  build_path="${MY_DIR}/../../${repo}/sh/build_docker_images.sh" # [1]
  if  [ -f "${build_path}" ]; then
    BARE_BUILD_ONLY=true ${build_path}
  fi
done

# [1] docker-compose docs claim you can specify
# a .env file in the same dir as docker-compose.yml
# and it will be found. Alas it seems not...
# https://github.com/docker/compose/issues/3381
# so I'm explicitly cd'ing.
