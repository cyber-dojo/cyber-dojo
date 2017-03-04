#!/bin/bash
set -e

my_dir="$( cd "$( dirname "${0}" )" && pwd )"
. ${my_dir}/env-var-repos.sh

for repo in ${CYBER_DOJO_REPOS[@]}; do
  rm -rf ${my_dir}/../../${repo}
done

