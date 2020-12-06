
# Hi. Welcome to cyber-dojo :-)

- [cyber-dojo](https://cyber-dojo.org) is where programmers meet to [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) programming!
- cyber-dojo is <em>not</em> an **IDE**, an **I**ndividual **D**evelopment **E**nvironment
- cyber-dojo <em>is</em> an **IDE**, an **I**nteractive **D**ojo **E**nvironment!
- cyber-dojo is about [shared](http://jonjagger.blogspot.co.uk/2013/10/teams.html) [learning](http://jonjagger.blogspot.co.uk/2013/10/learning.html)
- in a cyber-dojo you [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) by going <em>slower</em> and focusing on [improving](http://jonjagger.blogspot.co.uk/2014/02/improving.html) rather than finishing
- [cyber-dojo foundation](http://blog.cyber-dojo.org/2015/08/cyber-dojo-foundation.html) is a registered Scottish Charitable Incorporated Organisation
- How can I [contribute to developing cyber-dojo](https://github.com/cyber-dojo/cyber-dojo/blob/master/CONTRIBUTING.md)?

- - - -
- Running a server
  * [on docker](#running-a-server-on-docker)
  * [on docker swarm](#running-a-server-on-docker-swarm)
- Versioning
  * [listing the current version](#listing-the-current-version)
  * [listing installed versions](#listing-installed-versions)
  * [updating the server to the latest version](#updating-the-server-to-the-latest-version)
  * [setting the server to a specific version](#setting-the-server-to-a-specific-version)
- Overriding the default...
  * [port](#overriding-the-default-port)
  * [start-point images](#overriding-the-default-start-point-images)
  * [nginx image](#overriding-the-default-nginx-image)
  * [rails web image](#overriding-the-default-rails-web-image)
  * [dot env files](#overriding-the-default-dot-env-files)

- - - -
# running a server on docker
Follow [these instructions](https://blog.cyber-dojo.org/2014/09/setting-up-your-own-cyber-dojo-server.html)
to install the `cyber-dojo` bash script and to prepare your server.
```bash
$ cyber-dojo up
...
$ cyber-dojo version
Version: 0.1.19
   Type: public
...
```

# running a server on docker swarm
This is currently in beta!
Follow [these instructions](https://blog.cyber-dojo.org/2014/09/setting-up-your-own-cyber-dojo-server.html)
to install the `cyber-dojo` bash script and to prepare your server.
```bash
$ export CYBER_DOJO_SWARM=true
$ cyber-dojo up
```

# listing the current version
```bash
$ cyber-dojo version
Version: 0.1.23
   Type: public
```

# listing installed versions
From 0.1.50 onwards:
```bash
$ cyber-dojo version ls
0.1.49              2019-11-21 21:31:09 +0000 UTC
0.1.48              2019-11-20 12:52:04 +0000 UTC
...
0.1.21              2019-08-07 11:51:48 +0000 UTC
...
```

# updating the server to the latest version
```bash
$ cyber-dojo update latest
$ cyber-dojo version
Version: 0.1.49
   Type: public
...
# Now make it live...
$ cyber-dojo up
Using version=0.1.49 (public)
...
```

# setting the server to a specific version
```bash
$ cyber-dojo update 0.1.21
$ cyber-dojo version
Version: 0.1.21
   Type: public
...
# Now make it live...
$ cyber-dojo up
Using version=0.1.21 (public)
...
```

# overriding the default port
By default your cyber-dojo server will be on port 80.
* Override this port using the command-line argument `--port`. Eg
  ```bash
  $ cyber-dojo up --port=8000
  ...
  Using port=8000
  ...
  ```

# overriding the default start-point images
* The `cyber-dojo up` command uses three default start-point images (tagged appropriately)
  - --custom=[cyberdojo/custom-start-points](https://hub.docker.com/r/cyberdojo/custom-start-points/tags)
  - --exercises=[cyberdojo/exercises-start-points](https://hub.docker.com/r/cyberdojo/exercises-start-points/tags)
  - --languages=[cyberdojo/languages-start-points-common](https://hub.docker.com/r/cyberdojo/languages-start-points-common/tags)
* You can create and use your own alternative start-point images in place of these defaults if you wish.
  - Read how to create them by running:
    ```
    cyber-dojo start-point create --help
    ```
  - Read how to use them by running:
    ```
    cyber-dojo up --help
    ```

# overriding the default nginx image
* By default your cyber-dojo server will use
[cyberdojo/nginx](https://hub.docker.com/r/cyberdojo/nginx/tags) as its nginx
service image (tagged appropriately).
* From 0.1.47 onwards you can override this by exporting two
environment variables. Eg
  ```bash
  $ export CYBER_DOJO_NGINX_IMAGE=cucumber/nginx
  $ export CYBER_DOJO_NGINX_TAG=efd7e37
  $ cyber-dojo up ...
  ...
  Using nginx=cucumber/nginx:efd7e37
  ...
  ```

# overriding the default rails web image
* By default your cyber-dojo server will use
[cyberdojo/web](https://hub.docker.com/r/cyberdojo/web/tags)
as its web service image (tagged appropriately).
* From 0.1.28 onwards you can override this by exporting two
environment variables. Eg
  ```bash
  $ export CYBER_DOJO_WEB_IMAGE=turtlesec/web
  $ export CYBER_DOJO_WEB_TAG=84d6d0e
  $ cyber-dojo up ...
  ...
  Using web=turtlesec/web:84d6d0e
  ...
  ```

# overriding the default dot env files
* There are default .env files for the `web` and `nginx` services.
* You can override these by exporting two environment variables
set to the absolute path of your own .env file. Eg
  ```bash
  $ export CYBER_DOJO_NGINX_ENV=/home/fred/my_nginx.env
  $ export CYBER_DOJO_WEB_ENV=/home/fred/my_web.env
  $ cyber-dojo up
  ...
  Using nginx.env=/home/fred/my_nginx.env (custom)
  Using web.env=/home/fred/my_web.env (custom)
  ...
  ```
From 0.1.131 onwards, when an exercise starts a welcome dialog displays
traffic-light information. You can turn off this dialog with
the following `web.env` entry:
  ```
  STARTING_INFO_DIALOG=off
  ```

From 0.1.137 onwards, there is an experimental REPL service for Python.
You can turn this on with the following `web.env` entry:
  ```
  REPL=on
  ```


- - - -
# Services
Each repo in the github cyber-dojo organization builds a single docker image.
The main kubernetes backed https://cyber-dojo.org uses:

- [![CircleCI](https://circleci.com/gh/cyber-dojo/custom-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/custom-start-points) [custom-start-points](https://github.com/cyber-dojo/custom-start-points) - serves the custom start-points.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/exercises-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/exercises-start-points) [exercises-start-points](https://github.com/cyber-dojo/exercises-start-points) - serves the exercises start-points.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/languages-start-points.svg?style=svg)](https://circleci.com/gh/cyber-dojo/languages-start-points) [languages-start-points](https://github.com/cyber-dojo/languages-start-points) - serves the languages start-points.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/creator.svg?style=svg)](https://circleci.com/gh/cyber-dojo/creator) [creator](https://github.com/cyber-dojo/creator) - creates exercises (group and individual) with unique ids.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/dashboard.svg?style=svg)](https://circleci.com/gh/cyber-dojo/dashboard) [dashboard](https://github.com/cyber-dojo/dashboard) - a group session dashboard.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/differ.svg?style=svg)](https://circleci.com/gh/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/nginx.svg?style=svg)](https://circleci.com/gh/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - web-proxy, security, images (jpg) cache, and service routing.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/runner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs the tests and returns a `[stdout,stderr,status,timed_out,colour]` tuple.
- [![CircleCI](https://circleci.com/gh/cyber-dojo/saver.svg?style=svg)](https://circleci.com/gh/cyber-dojo/saver) [saver](https://github.com/cyber-dojo/saver) - persists group/individual exercises + code/test files (in a host dir volume-mounted to `/cyber-dojo`).
- [![CircleCI](https://circleci.com/gh/cyber-dojo/web.svg?style=svg)](https://circleci.com/gh/cyber-dojo/web) [web](https://github.com/cyber-dojo/web) - rails web-server (a monolith slowly being [Strangler Figged](https://martinfowler.com/bliki/StranglerFigApplication.html)).

Locally running servers also use:

- [![CircleCI](https://circleci.com/gh/cyber-dojo/commander.svg?style=svg)](https://circleci.com/gh/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
- [![CircleCI](https://circleci.com/gh/cyber-dojo/versioner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/versioner) [versioner](https://github.com/cyber-dojo/versioner) - holds consistent sets of image tags for all cyber-dojo services

- - - -
# Image dependencies

![Image Dependency Graph](dev/image_dependency_graph.png?raw=true "image dependency graph")

- - - -
# Domain model

![Domain model](dev/domain_model.png?raw=true "domain model")

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
