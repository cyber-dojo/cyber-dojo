
# Contributing

:+1::tada: Thanks for thinking about contributing! :tada::+1:

The cyber-dojo source code is split across two github organizations.
- [cyber-dojo-languages](https://github.com/cyber-dojo-languages) contains 100+
git repositories, one for each language+testFramework (eg `"Java, JUnit"`).
- [cyber-dojo](https://github.com/cyber-dojo) contains 20+ git repositories, one for
each dockerized microservice (eg runner) that together comprise the server.

- - - -
# contributing to cyber-dojo-languages

Here's a [complete list of all 100+ git repo URLs](https://github.com/cyber-dojo/languages-start-points/blob/master/start-points/all).

Each repository contains:
- a `docker/` dir to build the docker image. See below.
- a `start_point/` dir holding the minimal initial source files.
  These files always specify a function called `answer` that returns `6 * 9`
  and a test asserting `answer() == 42`. See below.

To get started, clone the git repository for a language,testFramework you are interested in,
  (or just pick one to learn how the automation works) eg
[Java, JUnit](https://github.com/cyber-dojo-languages/java-junit).
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  ```

In a terminal with [Docker](https://docs.docker.com/install/) installed, build
  the `"Java, Junit"` cyber-dojo docker image,
  and test its `start_point/` files, by running `pipe_build_up_test.sh`.
  It will:
  - Create `docker/Dockerfile` from `docker/Dockerfile.base`, augmented to
    satisfy the [runner's](https://github.com/cyber-dojo/runner) requirements.
  - Build a new docker image from `docker/Dockerfile`.
  - The name of the image is the `image_name` entry of `start_point/manifest.json`.
  - The names of the start-point source files are specified in
    the `visible_filenames` entry of `start_point/manifest.json`.
  - One of the `visible_filenames` is assumed to contain the pattern `6 * 9`.
  - The `visible_filenames` are sent to the
    [runner](https://github.com/cyber-dojo/runner) service, and the resulting `[stdout,stderr,status]` are passed to the Ruby lambda defined
    in `/docker/red_amber_green.rb`
  - Unmodified, the `visible_filenames` files should produce a `red` traffic-light.
  - With the `6 * 9` modified to `6 * 9sd`, an `amber` traffic-light.
  - With the `6 * 9` modified to `6 * 7`, a `green` traffic-light.
  - If the `visible_filenames` do not contain the pattern `6 * 9`,
    (eg the language uses infix notation) you can specify the red/amber/green
    modifications explicitly using an `options.json` file. See
    [nasm-assert](https://github.com/cyber-dojo-languages/nasm-assert/blob/master/start_point/options.json) for an example.

- For example:    
  ```bash
  cd java-junit
  ./pipe_build_up_test.sh
  ...
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 9",
    "duration": 2.935575839,
    ...
    "colour": "red"
  }
  PASSED:TRAFFIC_LIGHT:red:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 9sd",
    "duration": 1.744033281,
    ...
    "colour": "amber"    
  }
  PASSED:TRAFFIC_LIGHT:amber:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 7",
    "duration": 2.895220807,
    ...
    "colour": "green"    
  }
  PASSED:TRAFFIC_LIGHT:green:==================================
  ...
  ```

Specific ways you can contribute to cyber-dojo-languages.

- add a **coverage report** to your favourite language-testFramework.
  Please write the coverage report to a file called `report/coverage.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
- add a **lint report** to your favourite language-testFramework.
  Please write the lint report to a file called `report/style.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
- make a **faster run** (2.9s `duration` for Java,Junit)?
- make the `start_point/` source files **more idiomatic** for your favourite language-testFramework?
- make a `Dockerfile` **more idiomatic**?
- make a **faster docker build**?
- add a **new test-framework**, [testNG](https://testng.org/doc/index.html) anyone?
- add a **new language**, Elm, Scala, Lisp, Unison, ...
- make a **smaller docker image**?
For example, by changing it's base operating system.
The language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
However, if the official dockerhub image for a language is Ubuntu/Debian
then it's typically best to use that so it gets the `:latest` image.
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) `Alpine` based image is ~**120MB**.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) `Debian` based image is ~**1.2GB**.
  - the [C++(g++),GoogleMock](https://github.com/cyber-dojo-languages/gplusplus-googlemock) `Ubuntu` based image is ~**1.7GB**.

- - - -
# contributing to the cyber-dojo services

To get the source for *all* the cyber-dojo docker services:

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
