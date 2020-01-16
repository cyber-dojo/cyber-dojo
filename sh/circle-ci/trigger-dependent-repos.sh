#!/bin/bash -Ee

# Service repos curl and run this script in their CI pipelines.
#
# TODO: Env-var ORG is currently hardwired to cyber-dojo
#       It will need to be $1 so I can pass in cyber-dojo or cyber-dojo-languages
#
# TODO: Automate the git push
# I think this is done by changing
#    git push origin master
# to
#    USERNAME=cyber-dojo-machine-user
#    PASSWORD=Personal_API_Token
#    ORIGIN="https://${USERNAME}:${PASSWORD}@github.com/${ORG}/${REPO_NAME}.git"
#    git push "${ORIGIN}" master

declare -r FROM="${CIRCLE_PROJECT_REPONAME}" # eg runner
declare -r SHA="${CIRCLE_SHA1}"              # eg a9334c964f81800a910dc3d301543262161fbbff
declare -r REPO_NAMES="${@:1}"               # eg saver runner ...
declare -r ORG=cyber-dojo

declare -r COMMIT_URL="https://github.com/${ORG}/${FROM}/commit/${SHA}"

for REPO_NAME in ${REPO_NAMES}; do
  declare REPO_URL="https://github.com/${ORG}/${REPO_NAME}.git"
  cd /tmp
  git clone "${REPO_URL}"
  cd "${REPO_NAME}"
  declare MESSAGE="automated build trigger from ${COMMIT_URL}"
  echo "${MESSAGE}" > ${FROM}.trigger
  git add .
  git config --global user.email "cyber-dojo-machine-user@cyber-dojo.org"
  git config --global user.name "CyberDojoMachineUser"
  git commit -m "${MESSAGE}"
  declare ORIGIN="https://${CYBER_DOJO_MACHINE_USERNAME}:${CYBER_DOJO_MACHINE_PASSWORD}@github.com/${ORG}/${REPO_NAME}.git"
  git push "${ORIGIN}" master
done
