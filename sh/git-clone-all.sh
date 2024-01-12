#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo 'Cloning...'
source ${MY_DIR}/env-var-repos.sh
cd ${MY_DIR}/../..
for repo in ${CYBER_DOJO_REPOS[@]}; do
  if [ "${repo}" = "creator" ]; then
    ci=gitlab
  else
    ci=github
  fi
  git clone git@${ci}.com:cyber-dojo/creator.git
done
