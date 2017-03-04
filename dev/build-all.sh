#!/bin/bash
set -e

my_dir="$( cd "$( dirname "${0}" )" && pwd )"
. ${my_dir}/env-var-repos.sh

for repo in ${CYBER_DOJO_REPOS[@]}; do
  cd ${my_dir}/../../${repo} # [1]
  ./build.sh
done

# [1] docker-compose docs claim you can specify
# a .env file in the same dir as docker-compose.yml
# and it will be found. Alas not...
# https://github.com/docker/compose/issues/3381
# so I'm explicitly cd'ing.

