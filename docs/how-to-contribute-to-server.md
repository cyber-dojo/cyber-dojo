
# Contributing to cyber-dojo's server

:+1::tada: Thanks :tada::+1:

cyber-dojo uses:
- micro-services.
  - Each running from its own docker image.
- small git repos.
  - Each service lives in its own git repo.
- an immutable architecture.
  - Updates and fixes are made by creating, testing, and deploying *new* docker images.
- image tagging.
  - Each deployed docker image is *tagged* with the first seven chars of its git commit sha (on *master* at *HEAD*)
- a versioned architecture.
  - `cyberdojo/versioner` serves a set of image tags, one for each micro-service.
  - These are used when bringing up a cyber-dojo server with the `cyber-dojo up` command.

First, setup and learn how run a local cyber-dojo server. Please read and follow [these instructions](https://blog.cyber-dojo.org/2014/09/setting-up-your-own-cyber-dojo-server.html) which tell you:
- how to install the main `cyber-dojo` bash script used to control your server.
- how to set the correct permissions on the `/cyber-dojo` dir.
  - This dir is volume-mounted into the saver service.
- how to install `docker`.
  - If you are on Mac or Windows you must (currently) install `Docker Toolbox` and run from a Docker-QuickStart terminal as per the instructions.

Once you are running a local cyber-dojo server, ensure you can run these two tools:
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). Each cyber-dojo service lives in its own git repository.
- [docker-compose](https://docs.docker.com/compose/install/). Each repository has a `docker-compose.yml` file used when building and testing its service.

Install the source for *all* the cyber-dojo services.
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
src/exercises-start-points
src/languages-start-points
src/creator
src/differ
src/nginx
src/runner
src/saver
src/model
src/web
src/commander
src/versioner
```

Each directory holds a git repo with a `build_test_publish.sh` script which:
- builds its docker image
- runs its tests (from inside a docker container run from the docker image)
- if they pass, tags the docker image
- if running on ci
  - pushes the tagged docker image to [dockerhub](https://hub.docker.com/search/?q=cyberdojo&type=image)
  - deploys the tagged docker image to [https://beta.cyber-dojo.org](https://beta.cyber-dojo.org)
  - may also deploy the tagged docker image to [https://cyber-dojo.org](https://cyber-dojo.org)
- if running locally
  - read [versioner's README](https://github.com/cyber-dojo/versioner/blob/master/README.md)
    to learn how to make one or more of its tags refer to locally built images.
