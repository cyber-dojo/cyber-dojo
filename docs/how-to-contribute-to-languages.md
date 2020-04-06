
# Contributing to cyber-dojo's languages

:+1::tada: Thanks :tada::+1:

Here's a [complete list of all 100+ git repo URLs](https://github.com/cyber-dojo/languages-start-points/blob/master/start-points/all) from Assembler through to Zig!

- If you want to update an **existing language-testFramework** then git clone it.
  For example [java-junit](https://github.com/cyber-dojo-languages/java-junit):
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  ```
- If you want to add a **new testFramework** to an **existing language**, clone one
  of the languages' existing testFrameworks, rename it, and modify it.
  For example, to add [testNG](https://testng.org/doc/index.html)
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  mv java-junit java-testng
  ...
  ```
- If you want to add a **new testFramework** for a **new language**, clone an existing language repo and one of its testFramework repos, rename them, and modify them.
  For example [java](https://github.com/cyber-dojo-languages/java) and [java-junit](https://github.com/cyber-dojo-languages/java-junit)
  ```bash
  git clone https://github.com/cyber-dojo-languages/java.git
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  mv java lisp
  mv java-junit lisp-test
  ...
  ```

Each language-testFramework (eg `java-junit`) repository contains:

- a `docker/` dir to build the docker image. See below.
- a `start_point/` dir holding the minimal initial source files.
  These files always specify a function called `answer` that returns `6 * 9` and a
  test asserting `answer() == 42`. See below.

In a terminal with [Docker](https://docs.docker.com/install/) installed, build and test the docker image by running `pipe_build_up_test.sh` which will:

- Create `docker/Dockerfile` from `docker/Dockerfile.base`, augmented to satisfy
  the [runner's](https://github.com/cyber-dojo/runner) requirements.
- Build a new docker image from `docker/Dockerfile`.
- The name of the image is the `image_name` entry of `start_point/manifest.json`.
- The names of the start-point source files are specified in the `visible_filenames`
  entry of `start_point/manifest.json`.
- One of the `visible_filenames` is assumed to contain the pattern `6 * 9`.
- The `visible_filenames` are sent to the [runner](https://github.com/cyber-dojo/runner) service,
  and the resulting `[stdout,stderr,status]` are passed to the Ruby lambda defined
  in `/docker/red_amber_green.rb`
- Unmodified, the `visible_filenames` files should produce a `red` traffic-light.
- With the `6 * 9` modified to `6 * 9sd`, an `amber` traffic-light.
- With the `6 * 9` modified to `6 * 7`, a `green` traffic-light.
- If the `visible_filenames` do not contain the pattern `6 * 9`, (eg the language uses infix
  notation) you can specify the red/amber/green modifications explicitly using an `options.json`
  file. See [nasm-assert](https://github.com/cyber-dojo-languages/nasm-assert/blob/master/start_point/options.json) for an example.

An `pipe_build_up_test.sh` run looks like this:    
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

Specific ways you can contribute to cyber-dojo-languages:

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
- add a **new language**, Elm, Julia, Lisp, Scala, Racket, Unison, ...
- split the [Rust-test](https://github.com/cyber-dojo-languages/rust-test) starting file into two; one for the test, one for the code
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
