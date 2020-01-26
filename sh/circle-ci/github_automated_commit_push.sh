#!/bin/bash -Eeu

# CI pipeline scripts curl and run this script.
#
# NB:1 This script does NOT trigger a CircleCI API POST request. See below.
# NB:2 This script cannot (easily) be run from such a trigger. See below.
#
# In a CircleCI pipeline, a context must set these two env-vars:
#   CYBER_DOJO_MACHINE_USER_USERNAME=...username...
#   CYBER_DOJO_MACHINE_USER_PASSWORD=...Github_Personal_access_Token...
# And that context must be set in the .circleci/config.yml file.

readonly TMP_DIR=$(mktemp -d /tmp/XXXXXX)
remove_tmp_dir() { rm -rf "${TMP_DIR}" > /dev/null; }
trap remove_tmp_dir EXIT

# The repo whose CI pipeline is running...
declare -r FROM_ORG="${1}"  # eg cyber-dojo
declare -r FROM_REPO="${2}" # CIRCLE_PROJECT_REPONAME # eg runner
declare -r FROM_SHA="${3}"  # CIRCLE_SHA1 # eg a9334c964f81800a910dc3d301543262161fbbff

# The dependent repos, each being triggered via an automated git commit+push
declare -r TO_ORG="${4}"          # eg cyber-dojo
declare -r TO_REPO_NAMES="${@:5}" # eg saver runner ...

declare -r FROM_COMMIT="https://github.com/${FROM_ORG}/${FROM_REPO}/commit/${FROM_SHA}"

for TO_REPO_NAME in ${TO_REPO_NAMES}; do
  declare TO_REPO_URL="https://github.com/${TO_ORG}/${TO_REPO_NAME}.git"
  cd "${TMP_DIR}"
  git clone "${TO_REPO_URL}"
  cd "${TO_REPO_NAME}"
  declare MESSAGE="Automated build trigger from ${FROM_COMMIT}"
  echo "${MESSAGE}" > .circleci/${FROM_REPO}.trigger
  git add .
  # Don't use --global so you can test the script locally.
  git config user.email "cyber-dojo-machine-user@cyber-dojo.org"
  git config user.name "CyberDojoMachineUser"
  git commit -m "${MESSAGE}"
  declare ORIGIN="https://${CYBER_DOJO_MACHINE_USER_USERNAME}:${CYBER_DOJO_MACHINE_USER_PASSWORD}@github.com/${TO_ORG}/${TO_REPO_NAME}.git"
  git push "${ORIGIN}" master
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# https://circleci.com/docs/2.0/api-job-trigger/
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# NB:1
# Triggering a CircleCI workflow via a CircleCI API POST request
# means the latest git-commit sha (CIRCLE_SHA1) is _NOT_ unique
# and Helm (Kubernetes) will NOT deploy unless it sees a SHA change.
# So I don't trigger via an API POST. Instead I do a
# [git commit] + [git push] which causes a SHA change.
#
# NB:2
# <quote>
# Jobs that are triggered via the API do **not** have access
# to environment variables created for a CircleCI Context
# </quote>
# Instead they have to be repeatedly defined for each project.
# But one project can Import (env) Variables from another project.
# See https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project
