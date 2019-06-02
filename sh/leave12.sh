#!/bin/bash

# This file assumes all 64 avatars have started
# in the given kata. It removes 54 named avatars so
# that only the 12 you want are left.
# If the kata's ID is E7139819FF then you call this script
# by passing two arguments E7 139819FF
# The 12 avatars that it leaves behind are
#    alligator butterfly dolphin elephant frog
#    koala lion panda raccoon snake tiger wolf
# Must be called from _inside_ the storer docker container
# docker exec -it cyber-dojo-storer sh

cd /usr/src/cyber-dojo/katas
cd ${1}
cd ${2}
rm -rf antelope bat bear bee beetle buffalo cheetah crab deer eagle
rm -rf flamingo fox gopher gorilla heron hippo hummingbird hyena
rm -rf jellyfish kangaroo kingfisher leopard lizard lobster
rm -rf moose mouse ostrich owl parrot peacock penguin porcupine puffin
rm -rf rabbit ray rhino salmon seal shark skunk spider squid squirrel
rm -rf starfish swan toucan tuna turtle vulture walrus whale zebra
