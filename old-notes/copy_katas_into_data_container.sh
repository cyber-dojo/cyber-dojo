#!/bin/bash

# Simple script to copy saved local katas (on hard disk)
# into the cyber-dojo-web data-container (on the same server)
# Useful for
# 1. cyber-dojo.org so all katas are inside the data-container again
# 2. copying katas saved from short-lived servers into long-lived servers.

# Notes.
# o) make sure you change src_path to katas location on your hard disk
#    eg /var/www/cyber-dojo/katas
# o) does not delete the dir after transferring it.
#    If you are transferring a large amount of data you'll need a large
#    amount of free disk space.
# o) does not ensure the copied files inside the
#    cyber-dojo-web data container have the correct rights. You may need to
#    add a [chown -R cyber-dojo] docker command
# o) assumes a cyber-dojo server is running and hence there
#    is an alive cyber-dojo-web container.
# o) sleeps each time round the loop so as not to hog the cpu if
#    you are running this on a live cyber-dojo server.

src_path=/home/jrbjagger/katas
dst_path=/usr/src/cyber-dojo/katas

for i in {0..255}
do
  hex=`printf '%02X' ${i}`
  echo ${hex} # eg 3F
  tar -c -f - -C ${src_path} ${hex} | sudo docker exec -i cyber-dojo-web tar -x -f - -C ${dst_path}
  sleep 5s
done
