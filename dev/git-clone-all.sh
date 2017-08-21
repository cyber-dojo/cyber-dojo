#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. ${MY_DIR}/env-var-repos.sh

cd ${MY_DIR}/../..
for repo in ${CYBER_DOJO_REPOS[@]}; do
  git clone https://github.com/cyber-dojo/${repo}.git
done
