#!/bin/bash
set -e

my_dir="$( cd "$( dirname "${0}" )" && pwd )"
. ${my_dir}/env-var-repos.sh

cd ${my_dir}/../..
for repo in ${CYBER_DOJO_REPOS[@]}; do
  git clone https://github.com/cyber-dojo/${repo}.git
done
