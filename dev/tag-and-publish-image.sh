#!/bin/bash
set -e

# Service repos curl and run this script in their CI pipelines.

readonly project=${CIRCLE_PROJECT_REPONAME}
docker tag  cyberdojo/${project}:latest cyberdojo/${project}:${CIRCLE_SHA1:0:7}
docker tag  cyberdojo/${project}:latest cyberdojo/${project}:beta

echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
docker push cyberdojo/${project}:${CIRCLE_SHA1:0:7}
docker push cyberdojo/${project}:beta
docker push cyberdojo/${project}:latest
