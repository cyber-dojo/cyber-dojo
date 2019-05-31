
# Building your own cyber-dojo server from source

[Ensure docker is installed](http://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html).
If you are on a Windows/Mac note that these instructions specify to
install DockerToolbox.

To get all the source:

```
mkdir src
cd src
git clone https://github.com/cyber-dojo/cyber-dojo.git
./cyber-dojo/dev/git-clone-all.sh
cd ..
```

This will create the following directory structure (each directory holds a git repo):

```
src/custom
src/cyber-dojo
src/commander
src/differ
src/exercises
src/grafana
src/languages
src/mapper
src/nginx
src/prometheus
src/ragger
src/runner
src/saver
src/web
src/zipper
```

To build your server from these repos:
```
src/cyber-dojo/dev/build-all.sh
```

To bring up your server:
```
src/commander/cyber-dojo start-point up
```

To bring down your server:
```
src/commander/cyber-dojo down
```

- - - -

Each repo in the github cyber-dojo organization builds a single docker image.

These are the main service images:
  * [![Build Status](https://travis-ci.org/cyber-dojo/commander.svg?branch=master)](https://travis-ci.org/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
  * [![Build Status](https://travis-ci.org/cyber-dojo/custom.svg?branch=master)](https://travis-ci.org/cyber-dojo/custom) [custom](https://github.com/cyber-dojo/custom) - serves the custom start-points
  * [![Build Status](https://travis-ci.org/cyber-dojo/differ.svg?branch=master)](https://travis-ci.org/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files  
  * [![Build Status](https://travis-ci.org/cyber-dojo/exercises.svg?branch=master)](https://travis-ci.org/cyber-dojo/exercises) [exercises](https://github.com/cyber-dojo/exercises) - serves the exercises start-points  
  * [![Build Status](https://travis-ci.org/cyber-dojo/languages.svg?branch=master)](https://travis-ci.org/cyber-dojo/languages) [languages](https://github.com/cyber-dojo/languages) - serves the languages start-points  
  * [![Build Status](https://travis-ci.org/cyber-dojo/mapper.svg?branch=master)](https://travis-ci.org/cyber-dojo/mapper) [mapper](https://github.com/cyber-dojo/mapper) - maps session ids ported from old architecture (storer) to new architecture (saver) by porter service.  
  * [![Build Status](https://travis-ci.org/cyber-dojo/nginx.svg?branch=master)](https://travis-ci.org/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - internet-facing web-server
  * [![Build Status](https://travis-ci.org/cyber-dojo/ragger.svg?branch=master)](https://travis-ci.org/cyber-dojo/ragger) [ragger](https://github.com/cyber-dojo/ragger) - determines the traffic-light colour of [stdout,stderr,status] Red/Amber/Green
  * [![Build Status](https://travis-ci.org/cyber-dojo/runner.svg?branch=master)](https://travis-ci.org/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs an avatar's tests and returns [stdout,stderr,status]  
  * [![Build Status](https://travis-ci.org/cyber-dojo/saver.svg?branch=master)](https://travis-ci.org/cyber-dojo/saver) [saver](https://github.com/cyber-dojo/saver) - saves groups/katas and code/test files in a host dir volume-mounted to /cyber-dojo
  * [web](https://github.com/cyber-dojo/web) [![CircleCI](https://circleci.com/gh/cyber-dojo/web.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web) - simple rails web-server  
  * [![Build Status](https://travis-ci.org/cyber-dojo/zipper.svg?branch=master)](https://travis-ci.org/cyber-dojo/zipper) [zipper](https://github.com/cyber-dojo/zipper) - creates tgz files for download



The main service repos each contain a `pipe_build_up_test.sh` script which:
- rebuilds the service's docker image
- starts a container from this server image
- shells into the server container
- runs the server tests (with coverage)
- rebuilds a service client's docker image
- starts a client container
- shells into the client container
- runs the client tests (with coverage)

- - - -

Image dependencies

![Image Dependency Graph](image_dependency_graph.png?raw=true "image dependency graph")

- - - -

Domain model

![Domain model](domain_model.png?raw=true "domain model")
