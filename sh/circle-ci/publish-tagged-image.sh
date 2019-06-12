#!/bin/bash
set -ex

# Service repos curl and run this script in their CI pipelines.

declare -r NAME="${CIRCLE_PROJECT_REPONAME}" # eg runner
declare -r SHA="${CIRCLE_SHA1}"              # eg a9334c964f81800a910dc3d301543262161fbbff

docker push cyberdojo/${NAME}:${SHA:0:7}
docker push cyberdojo/${NAME}:beta
docker push cyberdojo/${NAME}:latest
docker logout
