
# This script runs in .circleci/config.yml after
# a cyberdojo/starter-base docker image is
# successfully created and pushed to dockerhub.
# Originally it did this:
#
# curl --fail -X POST \
#  https://circleci.com/api/v1.1/project/github/cyber-dojo/languages/build?circle-token=${CIRCLECI_BUILD_TOKEN}
#
# The problems with this approach are
# o) when the trigger reached language's .circleci/config.yml
#    its Helm commands did not see a SHA change, so did not see an
#    image-tag change, and so did not do a deployment.
# o) Since the SHA did not change, the image was being built
#    with the same tag multiple times. Not good practice.
#
# To avoid these problems we now do a [git commit] + [git push]
# using a "machine-user" called cyber-dojo-machine-user.
# See https://circleci.com/docs/2.0/gh-bb-integration/#creating-a-machine-user
#
# There are four git-repos/circleci-projects involved...
# 1) cyber-dojo/starter-base
# 2) cyber-dojo/custom
# 3) cyber-dojo/exercises
# 4) cyber-dojo/languages
#
# The ./circleci/config.yml for 1) has to do a [git commit] + [git push]
# into the github repo for 2)3)4)
#
# The cyber-dojo-machine-user had to be added as a collaborator
# (with Admin rights) to the github repo for 1).
# Only then could I...
# o) log out of Github and CircleCI
# o) log into Github as cyber-dojo-machine-user
# o) log into CircleCI [via Github]
# o) access CircleCI's settings for starter-base project in cyber-dojo organization
# o) click [Checkout SSH keys] from menu on left
# o) automatically generate the cyber-dojo-machine-user's SSH keys
# o) automatically add cyber-dojo-machine-user's SSH keys
#
# Note too that these SSH keys are the preferred SSH keys for this project
# and so do not have to be explicitly set in the .circleci/config.yml file.
# Once the SSH keys have been added, the collaborator rights (on Github)
# can be (and were) dropped from Admin back to Write.
#
# The cyber-dojo-machine-user has to be retained as a collaborator
# (with Write rights) to the github repo for 2)3)4).
# This is so the [git push] works.
