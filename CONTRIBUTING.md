
# Contributing

:+1::tada: Thanks for thinking about contributing! :tada::+1:

The cyber-dojo source code is split across two github organizations.
- [cyber-dojo](https://github.com/cyber-dojo) contains 20+ repositories, one for
each dockerized microservice that together comprise the server.
- [cyber-dojo-languages](https://github.com/cyber-dojo-languages) contains 100+
repositories, one for each language+testFramework (eg "Java, JUnit").

- - - -
# contributing to cyber-dojo-languages

This is the simplest way to contribute and a good way to start.
- git clone the repository for your chosen language,testFramework, eg
[Java, JUnit](https://github.com/cyber-dojo-languages/java-junit).
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  ```
- in a terminal with Docker installed, build the [Java,Junit] cyber-dojo docker image,
  and test the [Java,JUnit] cyber-dojo start_point source files, by running `pipe_build_up_test.sh`. It will:
  - create `docker/Dockerfile` from `docker/Dockerfile.base`, augmented to
    satisfy the [runner's](https://github.com/cyber-dojo/runner) requirements.
  - build a new docker image from `docker/Dockerfile`. The name of this
    image is the `image_name` entry of `start_point/manifest.json`.
  - the names of the start-point source files are specified in
    the `visible_filenames` entry of `start_point/manifest.json`.
  - one of the `visible_filenames` must contain the pattern `6 * 9`
  - the `visible_filenames` are sent to the
    [runner](https://github.com/cyber-dojo/runner) service, and the resulting `[stdout,stderr,status]` are passed to the Ruby lambda defined
    in `/docker/red_amber_green.rb`
  - unmodified, the `visible_filenames` files should produce a `red` traffic-light.
  - with the `6 * 9` modified to `6 * 9sdsd`, an `amber` traffic-light.
  - with the `6 * 9` modified to `6 * 7`, a `green` traffic-light.
  - if the `visible_filenames` do not contain the pattern `6 * 9`
    (eg the language uses infix notation) you can specify the red/amber/green
    modifications explicitly using an `options.json` file. See
    [nasm-assert](https://github.com/cyber-dojo-languages/nasm-assert/blob/master/start_point/options.json) for an example
- for example:    
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
  }
  PASSED:TRAFFIC_LIGHT:red:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 9sd",
    "duration": 1.744033281,
    ...
  }
  PASSED:TRAFFIC_LIGHT:amber:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 7",
    "duration": 2.895220807,
    ...
  }
  PASSED:TRAFFIC_LIGHT:green:==================================
  ...
  ```
- Can you improve/update the Java,JUnit docker image? (built from `java-junit/docker/Dockerfile.base`)?
- Can you improve the start point files (which live in `java-junit/start_point/`)?
- Can you reduce the runtime `duration`?

Here's a [complete list](https://github.com/cyber-dojo/languages-start-points/blob/master/start-points/all)
of all language+testFramework repos in cyber-dojo-languages.

Specific ways you can contribute to cyber-dojo-languages.

- convert large docker images to smaller Alpine based images.
The language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
However, if the official dockerhub image for a language is Ubuntu/Debian
then it's typically best to use that so it gets the `:latest` image.
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) Alpine based image is ~120MB.
  - the [C++(g++),GoogleMock](https://github.com/cyber-dojo-languages/gplusplus-googlemock) Ubuntu based image is ~1.7GB.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) Debian based image is ~1.2GB.
- add a new test-framework, [testNG](https://testng.org/doc/index.html) anyone?
- add a new language, Elm, Scala, Prolog, Lisp, SQL, Unison, ...
- suggest a [new exercise](https://github.com/cyber-dojo/start-points-exercises)
