#!/bin/bash
set -e

# Script used in .travis.yml files to [docker push] a
# successfully built docker image to dockerhub followed,
# if pushed successfully, by triggering the .travis.yml
# files in dependent git repos.

# I do NOT run this in .travis.yml's after_success: section
# because when commands in the after_success: section fail
# they do NOT fail the travis build.
# https://github.com/travis-ci/travis-ci/issues/758

# This file is itself curl'd by several cyber-dojo repos'
# .travis.yml files which is why it curl's trigger-build.js
# The .travis.yml file running this needs to set
# language: node_js

# Needs DOCKER_USERNAME and DOCKER_PASSWORD Travis
# environment variables set for the dockerhub repo the
# docker image is being pushed to.

if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
  BRANCH=${TRAVIS_BRANCH}
else
  BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}
fi

if [ "${BRANCH}" == "master" ]; then
  docker login --username "${DOCKER_USERNAME}" --password "${DOCKER_PASSWORD}"
  TAG_NAME=$(basename ${TRAVIS_REPO_SLUG})
  docker push cyberdojo/${TAG_NAME}
  echo "PUSHED cyberdojo/${TAG_NAME} to dockerhub"
  npm install travis-ci
  script=trigger-build.js
  curl -O https://raw.githubusercontent.com/cyber-dojo/cyber-dojo/master/shared/${script}
  node ${script} ${*}
fi
