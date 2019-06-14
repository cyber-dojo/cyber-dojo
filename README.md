
# Hi. Welcome to cyber-dojo :-)

* a [dojo](http://en.wikipedia.org/wiki/Dojo) is a place where martial artists meet to practice their martial art
* a cyber-dojo is where programmers meet to [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) programming!
* a cyber-dojo is <em>not</em> an **IDE**, an **I**ndividual **D**evelopment **E**nvironment
* a cyber-dojo <em>is</em> an **IDE**, an **I**nteractive **D**ojo **E**nvironment!
* a cyber-dojo is about [shared](http://jonjagger.blogspot.co.uk/2013/10/teams.html) [learning](http://jonjagger.blogspot.co.uk/2013/10/learning.html)
* in a cyber-dojo you [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) by going <em>slower</em> and focusing on [improving](http://jonjagger.blogspot.co.uk/2014/02/improving.html) rather than finishing
* [cyber-dojo foundation](http://blog.cyber-dojo.org/2015/08/cyber-dojo-foundation.html) is a registered Scottish Charitable Incorporated Organisation
* How do I [practice programming in cyber-dojo](http://blog.cyber-dojo.org/2014/08/getting-started.html)?
* Try it now at [http://cyber-dojo.org](http://cyber-dojo.org).
* How can I [contribute to developing cyber-dojo](https://github.com/cyber-dojo/cyber-dojo/blob/master/CONTRIBUTING.md)?

- - - -
# Services
Each repo in the github cyber-dojo organization builds a single docker image.

* [![CircleCI](https://circleci.com/gh/cyber-dojo/commander.svg?style=svg)](https://circleci.com/gh/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
* [![CircleCI](https://circleci.com/gh/cyber-dojo/custom.svg?style=svg)](https://circleci.com/gh/cyber-dojo/custom) [custom](https://github.com/cyber-dojo/custom) - serves the custom start-points
* [![CircleCI](https://circleci.com/gh/cyber-dojo/differ.svg?style=svg)](https://circleci.com/gh/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files
* [![CircleCI](https://circleci.com/gh/cyber-dojo/exercises.svg?style=svg)](https://circleci.com/gh/cyber-dojo/exercises) [exercises](https://github.com/cyber-dojo/exercises) - serves the exercises start-points
* [![CircleCI](https://circleci.com/gh/cyber-dojo/grafana.svg?style=svg)](https://circleci.com/gh/cyber-dojo/grafana) [grafana](https://github.com/cyber-dojo/grafana) - displays monitoring data
* [![CircleCI](https://circleci.com/gh/cyber-dojo/languages.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages) [languages](https://github.com/cyber-dojo/languages) - serves the languages start-points
* [![CircleCI](https://circleci.com/gh/cyber-dojo/mapper.svg?style=svg)](https://circleci.com/gh/cyber-dojo/mapper) [mapper](https://github.com/cyber-dojo/mapper) - maps session ids [ported](https://github.com/cyber-dojo/porter) from old architecture (storer) to new architecture (saver)
* [![CircleCI](https://circleci.com/gh/cyber-dojo/nginx.svg?style=svg)](https://circleci.com/gh/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - web-proxy, security, and images (png) cache
* [![CircleCI](https://circleci.com/gh/cyber-dojo/prometheus.svg?style=svg)](https://circleci.com/gh/cyber-dojo/prometheus) [prometheus](https://github.com/cyber-dojo/prometheus) - stores monitoring data
* [![CircleCI](https://circleci.com/gh/cyber-dojo/ragger.svg?style=svg)](https://circleci.com/gh/cyber-dojo/ragger) [ragger](https://github.com/cyber-dojo/ragger) -  determines the traffic-light colour of runner's [stdout,stderr,status] as **r**ed-**a**mber-**g**reen
* [![CircleCI](https://circleci.com/gh/cyber-dojo/runner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs the tests and returns [stdout,stderr,status,timed_out]  
* [![CircleCI](https://circleci.com/gh/cyber-dojo/saver.svg?style=svg)](https://circleci.com/gh/cyber-dojo/saver) [saver](https://github.com/cyber-dojo/saver) - saves groups/katas and code/test files in a host dir volume-mounted to /cyber-dojo  
* [![CircleCI](https://circleci.com/gh/cyber-dojo/versioner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/versioner) [versioner](https://github.com/cyber-dojo/versioner) - holds sets of image tags comprising specific cyber-dojo versions
* [![CircleCI](https://circleci.com/gh/cyber-dojo/web.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web) [web](https://github.com/cyber-dojo/web) - rails web-server
* [![CircleCI](https://circleci.com/gh/cyber-dojo/zipper.svg?style=svg)](https://circleci.com/gh/cyber-dojo/zipper) [zipper](https://github.com/cyber-dojo/zipper) - creates tgz files for download

- - - -
# Image dependencies

![Image Dependency Graph](dev/image_dependency_graph.png?raw=true "image dependency graph")

- - - -
# Domain model

![Domain model](dev/domain_model.png?raw=true "domain model")

- - - -
# Building your own cyber-dojo server from source

[Ensure docker is installed](http://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html). If you are on a Windows/Mac note that these instructions specify to
install Docker**Toolbox** (and <em>not</em> Docker for Windows/Mac).

To get all the source:

```bash
mkdir src
cd src
git clone https://github.com/cyber-dojo/cyber-dojo.git
./cyber-dojo/sh/git-clone-all.sh
cd ..
```

This will create the following directory structure (each directory holds a git repo):

```
src/commander
src/custom
src/cyber-dojo
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
src/cyber-dojo/sh/build-all.sh
```

To bring up your server:
```
src/commander/cyber-dojo start-point up
```

To bring down your server:
```
src/commander/cyber-dojo down
```

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
