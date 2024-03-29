#!/bin/bash -Eeu

# Some of these have a build-order dependency
export CYBER_DOJO_REPOS=(\
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
                  web \
                  versioner \
                  commander \
                  gcloud-kubectl-helm \
                  k8s-install \
                  service-yaml \
                  helm-charts
        )
