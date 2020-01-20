#!/bin/bash -Eeu

# Some of these have a build-order dependency
export CYBER_DOJO_REPOS=(\
                  ruby-base \
                  rack-base \
                  docker-base \
                  web-base \
                  start-points-base \
                  custom-start-points \
                  exercises-start-points \
                  languages-start-points \
                  avatars \
                  differ \
                  nginx \
                  puller \
                  runner \
                  saver \
                  web \
                  versioner \
                  commander \
        )
