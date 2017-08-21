#!/bin/bash
set -e

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
. ${MY_DIR}/env-var-repos.sh

for repo in ${CYBER_DOJO_REPOS[@]}; do
  rm -rf ${MY_DIR}/../../${repo}
done

