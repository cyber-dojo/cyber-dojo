#!/bin/bash
set -ex

# Service repos curl and run this script in their CI pipelines.

declare -r FROM="${CIRCLE_PROJECT_REPONAME}" # eg runner
declare -r SHA="${CIRCLE_SHA1}"              # eg a9334c964f81800a910dc3d301543262161fbbff
declare -r REPO_NAMES="${@:1}"               # eg saver ragger ...

declare -r COMMIT_URL="https://github.com/cyber-dojo/${FROM}/commit/${SHA}"

for REPO_NAME in ${REPO_NAMES}; do
  declare REPO_URL="https://github.com/cyber-dojo/${REPO_NAME}.git"
  cd /tmp
  git clone "${REPO_URL}"
  cd "${REPO_NAME}"
  declare MESSAGE="automated build trigger from ${COMMIT_URL}"
  echo "${MESSAGE}" > ${FROM}.trigger
  git add .
  git config --global user.email "cyber-dojo-machine-user@cyber-dojo.org"
  git config --global user.name "Machine User"
  git commit -m "${MESSAGE}"
  git push origin master
done
