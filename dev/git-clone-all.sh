#!/bin/bash
set -e

my_dir="$( cd "$( dirname "${0}" )" && pwd )"
. ${my_dir}/env-var-repos.sh

cd ${my_dir}/../..
for repo in ${CYBER_DOJO_REPOS[@]}; do
  git clone https://github.com/cyber-dojo/${repo}.git
done

# - - - - - - - - - - - - - - - - - - - - - - - - - - -
# The cloned repos will track all branches, eg
#
#   $ cd runner
#
#   $ git branch
#   * master
#
#   $ git branch -a
#   * master
#     remotes/origin/HEAD -> origin/master
#     remotes/origin/master
#     remotes/origin/prometheus
#     remotes/origin/prometheus_middleware
#
#   $ git checkout prometheus
#   Branch prometheus set up to track remote branch prometheus from origin.
#   Switched to a new branch 'prometheus'
#
#   $ git status
#   On branch prometheus
#   Your branch is up-to-date with 'origin/prometheus'.
#   nothing to commit, working directory clean
#
#   $ git branch
#   master
#   * prometheus