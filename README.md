
# Hi. Welcome to cyber-dojo :-)

* [cyber-dojo](https://cyber-dojo.org) is where programmers meet to [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) programming!
* cyber-dojo is <em>not</em> an **IDE**, an **I**ndividual **D**evelopment **E**nvironment
* cyber-dojo <em>is</em> an **IDE**, an **I**nteractive **D**ojo **E**nvironment!
* cyber-dojo is about [shared](http://jonjagger.blogspot.co.uk/2013/10/teams.html) [learning](http://jonjagger.blogspot.co.uk/2013/10/learning.html)
* in a cyber-dojo you [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) by going <em>slower</em> and focusing on [improving](http://jonjagger.blogspot.co.uk/2014/02/improving.html) rather than finishing
* How do I [practice programming in cyber-dojo](http://blog.cyber-dojo.org/2014/08/getting-started.html)?
* How can I [contribute to developing cyber-dojo](https://github.com/cyber-dojo/cyber-dojo/blob/master/CONTRIBUTING.md)?

* [cyber-dojo foundation](http://blog.cyber-dojo.org/2015/08/cyber-dojo-foundation.html) is a registered Scottish Charitable Incorporated Organisation


- - - -
# Services
Each repo in the github cyber-dojo organization builds a single docker image.
The main kubernetes backed https://cyber-dojo.org uses:

* [![CircleCI](https://circleci.com/gh/cyber-dojo/custom-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/custom-start-points) [custom-start-points](https://github.com/cyber-dojo/custom-start-points) - serves the custom start-points
* [![CircleCI](https://circleci.com/gh/cyber-dojo/exercises-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/exercises-start-points) [exercises-start-points](https://github.com/cyber-dojo/exercises-start-points) - serves the exercises start-points
* [![CircleCI](https://circleci.com/gh/cyber-dojo/languages-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages-start-points) [languages-start-points](https://github.com/cyber-dojo/languages-start-points) - serves the languages start-points

* [![CircleCI](https://circleci.com/gh/cyber-dojo/avatars.svg?style=svg)](https://circleci.com/gh/cyber-dojo/avatars) [avatars](https://github.com/cyber-dojo/avatars) - serves the avatar names and images.
* [![CircleCI](https://circleci.com/gh/cyber-dojo/differ.svg?style=svg)](https://circleci.com/gh/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files
* [![CircleCI](https://circleci.com/gh/cyber-dojo/puller.svg?style=svg)](https://circleci.com/gh/cyber-dojo/puller) [puller](https://github.com/cyber-dojo/puller) - pulls the latest docker images named in the [custom-start-points](https://github.com/cyber-dojo/custom-start-points) and [languages-start-points](https://github.com/cyber-dojo/languages-start-points) services.
* [![CircleCI](https://circleci.com/gh/cyber-dojo/nginx.svg?style=svg)](https://circleci.com/gh/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - web-proxy, security, and images (jpg) cache
* [![CircleCI](https://circleci.com/gh/cyber-dojo/runner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs the tests and returns [stdout,stderr,status,timed_out,colour]  
* [![CircleCI](https://circleci.com/gh/cyber-dojo/saver.svg?style=svg)](https://circleci.com/gh/cyber-dojo/saver) [saver](https://github.com/cyber-dojo/saver) - saves groups/katas and code/test files in a host dir volume-mounted to /cyber-dojo  
* [![CircleCI](https://circleci.com/gh/cyber-dojo/web.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web) [web](https://github.com/cyber-dojo/web) - rails web-server
* [![CircleCI](https://circleci.com/gh/cyber-dojo/zipper.svg?style=svg)](https://circleci.com/gh/cyber-dojo/zipper) [zipper](https://github.com/cyber-dojo/zipper) - creates tgz files for download


Locally running servers also use:

* [![CircleCI](https://circleci.com/gh/cyber-dojo/commander.svg?style=svg)](https://circleci.com/gh/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
* [![CircleCI](https://circleci.com/gh/cyber-dojo/versioner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/versioner) [versioner](https://github.com/cyber-dojo/versioner) - holds consistent sets of image tags for all cyber-dojo services


- - - -
# Image dependencies

![Image Dependency Graph](dev/image_dependency_graph.png?raw=true "image dependency graph")

- - - -
# Domain model

![Domain model](dev/domain_model.png?raw=true "domain model")

- - - -
# Building your own cyber-dojo services from source

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

This will create the following directory structure
(each directory holds a git repo with a build_test_tag_publish.sh script):

```
src/cyber-dojo
src/ruby-base
src/rack-base
src/sinatra-base
src/docker-base
src/web-base
src/start-points-base
src/custom-start-points
src/custom-chooser
src/exercises-start-points
src/languages-start-points
src/avatars
src/creator
src/differ
src/nginx
src/puller
src/runner
src/saver
src/web
src/commander
src/versioner
```

To bring up your server:
```
src/commander/cyber-dojo up
```

This will download docker images for *every* language and test framework combination,
and for all the exercises.
If you don't want this, you will need to create your own start point docker images.
You will need three of these, for language, exercises and custom exercises.
Read the help docs about how to create them by running:

```
src/commander/cyber-dojo start-point create --help
```

Then start your cyber-dojo instance using the 'up' command.
Read the help docs about how to use this command by running:

```
src/commander/cyber-dojo up --help
```

To bring down your server:
```
src/commander/cyber-dojo down
```

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
