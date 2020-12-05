#!/bin/bash -Eeu

# Some of these have a build-order dependency
export CYBER_DOJO_REPOS=(\
                  ruby-base \
                  rack-base \
                  sinatra-base \
                  docker-base \
                  web-base \
                  start-points-base \
                  custom-start-points \
                  exercises-start-points \
                  languages-start-points \
                  creator \
                  dashboard
                  differ \
                  nginx \
                  runner \
                  saver \
                  model \
                  web \
                  versioner \
                  commander \
        )
