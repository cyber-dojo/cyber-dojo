
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
  * [on Kubernetes](#running-a-server-on-kubernetes)
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
- Misc
  * [List of MicroServices](#micro-services)
  * [Image dependencies](#image-dependencies)
  * [Domain model](#domain-model)
  * [Screenshots](#screenshots)
 
- - - -
# running a server on Kubernetes
Follow [these instructions](https://github.com/cyber-dojo/k8s-install)

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
This is exploratory only and may be dropped without notice.
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

From 0.1.291 onwards, you can turn off the review page's [fork] button
with the following `web.env` entry:
  ```
  FORK_BUTTON=off
  ```

From 0.1.319 onwards, you can turn off the [bashboard] button from the 
info toolbar with the following `web.env` entry:
  ```
  DASHBOARD_BUTTON=off
  ```

From 0.1.320 onwards, you can turn off traffic-light prediction with the
following `web.env` entry:
  ```
  PREDICT=off
  ```


- - - -
# Micro Services
Each repo in the github cyber-dojo organization builds a single docker image.  
The main Amazon ECS backed https://cyber-dojo.org uses:

- [![Github Action](https://github.com/cyber-dojo/custom-start-points/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/custom-start-points/actions) [custom-start-points](https://github.com/cyber-dojo/custom-start-points) - serves the custom start-points.
- [![Github Action](https://github.com/cyber-dojo/exercises-start-points/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/exercises-start-points/actions) [exercises-start-points](https://github.com/cyber-dojo/exercises-start-points) - serves the exercises start-points.
- [![Github Action](https://github.com/cyber-dojo/languages-start-points/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/languages-start-points/actions) [languages-start-points](https://github.com/cyber-dojo/languages-start-points) - serves the languages start-points.
- [![Github Action](https://github.com/cyber-dojo/differ/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/differ/actions) [differ](https://github.com/cyber-dojo/differ) - diffs two sets of files.
- [![Github Action](https://github.com/cyber-dojo/nginx/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/nginx/actions) [nginx](https://github.com/cyber-dojo/nginx) - web-proxy, security, images (jpg) cache, and service routing.
- [![Github Action](https://github.com/cyber-dojo/runner/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/runner/actions) [runner](https://github.com/cyber-dojo/runner) - runs the tests and returns `[stdout,stderr,status,timed_out,colour]`.
- [![Github Action](https://github.com/cyber-dojo/saver/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/saver/actions) [saver](https://github.com/cyber-dojo/saver) - persistent API for groups/katas.
- [![Github Action](https://github.com/cyber-dojo/creator/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/creator/actions) [creator](https://github.com/cyber-dojo/creator) - - UX for creating exercises (group and individual) with unique ids.
- [![Github Action](https://github.com/cyber-dojo/dashboard/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/dashboard/actions) [dashboard](https://github.com/cyber-dojo/dashboard) - UX for a group session dashboard.
- [![Github Action](https://github.com/cyber-dojo/web/actions/workflows/main.yml/badge.svg)](https://github.com/cyber-dojo/web/actions) [web](https://github.com/cyber-dojo/web) - UX for editing and reviewing.

Locally running servers also use:

- [![CircleCI](https://circleci.com/gh/cyber-dojo/commander.svg?style=svg)](https://circleci.com/gh/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
- [![CircleCI](https://circleci.com/gh/cyber-dojo/versioner.svg?style=svg)](https://circleci.com/gh/cyber-dojo/versioner) [versioner](https://github.com/cyber-dojo/versioner) - holds consistent sets of image tags for all cyber-dojo services

- - - -
# Image Dependencies

![Image Dependency Graph](dev/image_dependency_graph.png?raw=true "image dependency graph")

- - - -
# Domain Model

![Domain model](dev/domain_model.png?raw=true "domain model")

- - - -
# Screenshots

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
