
# Contributing to cyber-dojo's server

:+1::tada: Thanks :tada::+1:

First, setup and learn how run a local cyber-dojo server. Please read and follow [these instructions](https://blog.cyber-dojo.org/2014/09/setting-up-your-own-cyber-dojo-server.html). They tell you how to:
- install the main cyber-dojo bash script used to control your server.
- install `docker`. If you are on Mac or Windows you must install `Docker Toolbox` and run from a Docker-QuickStart terminal as instructed. A cyber-dojo server comprises many separate services, each running from its own docker image.
- set the correct permissions on the `/cyber-dojo` dir. This dir is volume-mounted into the saver service.

Once you are running a local cyber-dojo server, install these two tools:
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). Each cyber-dojo service lives in its own git repository.
- [docker-compose](https://docs.docker.com/compose/install/). Each repository has a `docker-compose.yml` file used when building and testing the service.

Now install the source for *all* the cyber-dojo docker services:
```bash
mkdir src
cd src
git clone https://github.com/cyber-dojo/cyber-dojo.git
./cyber-dojo/sh/git-clone-all.sh
cd ..
```

This will create the following directory structure:
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
src/exercises-chooser
src/languages-start-points
src/languages-chooser
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


Each directory holds a git repo with a `build_test_tag_publish.sh` script which:
- builds its docker-image
- runs its tests (from inside a container run from the image)
- if they pass, tags the docker-image
- if running on ci
  - pushes the docker-image to [dockerhub](https://hub.docker.com/search/?q=cyberdojo&type=image)
  - deploys the docker-image to [https://beta.cyber-dojo.org](https://beta.cyber-dojo.org)
  - may also deploy the docker-image to [https://cyber-dojo.org](https://cyber-dojo.org)


cyber-dojo uses:
- an immutable architecture. Updates and fixes are made by creating and deploying *new* docker images.
- image tagging. Each image's *tag* is the first seven chars of its git commit sha (on *master* at *HEAD*)
- a versioned architecture. The `cyberdojo/versioner` service serves a set of tags, which are used when bringing up your cyber-dojo server with the `cyber-dojo up` command.


You need to read [versioner's README](https://github.com/cyber-dojo/versioner/blob/master/README.md)
to learn:
- how `cyberdojo/versioner` uses these tags.
- how to make one or more of its tags refer to tags of locally built images.
