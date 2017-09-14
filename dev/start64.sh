#!/bin/bash

# Script to start all 64 avatars in a kata
# with the given ID.
# enter/start should be a post request but its not.
# Called directly from the server that is hosting cyber-dojo.
# This script does *not* live inside a docker container.

for run in {1..64}
do
  curl \
    -H "Content-Type: application/json" \
    --get \
    http://localhost/enter/start?id=${1}
done
