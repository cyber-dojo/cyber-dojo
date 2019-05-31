
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

These are the main services:
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/commander.svg?style=svg)](https://circleci.com/gh/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/custom.svg?style=svg)](https://circleci.com/gh/cyber-dojo/custom) [custom](https://github.com/cyber-dojo/custom) - serves the custom start-points
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/differ.svg?style=svg)](https://circleci.com/gh/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/exercises.svg?style=svg)](https://circleci.com/gh/cyber-dojo/exercises) [exercises](https://github.com/cyber-dojo/exercises) - serves the exercises start-points
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/languages.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages) [languages](https://github.com/cyber-dojo/languages) - serves the languages start-points
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/mapper.svg?style=svg)](https://circleci.com/gh/cyber-dojo/mapper) [mapper](https://github.com/cyber-dojo/mapper) - maps session ids [ported](https://github.com/cyber-dojo/porter) from old architecture (storer) to new architecture (saver)
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/nginx.svg?style=svg)](https://circleci.com/gh/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - web-proxy, security, and images (png) cache
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/ragger.svg?style=svg)](https://circleci.com/gh/cyber-dojo/ragger) [ragger](https://github.com/cyber-dojo/ragger) -  determines the traffic-light colour of runner's [stdout,stderr,status] as **r**ed-**a**mber-**g**reen
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/runner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs the tests and returns [stdout,stderr,status,timed_out]  
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/saver.svg?style=svg)](https://circleci.com/gh/cyber-dojo/saver) [saver](https://github.com/cyber-dojo/saver) - saves groups/katas and code/test files in a host dir volume-mounted to /cyber-dojo  
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/web.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web) [web](https://github.com/cyber-dojo/web) - rails web-server
  * [![CircleCI](https://circleci.com/gh/cyber-dojo/zipper.svg?style=svg)](https://circleci.com/gh/cyber-dojo/zipper) [zipper](https://github.com/cyber-dojo/zipper) - creates tgz files for download



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
