
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
- install docker by following the instructions at the top of...
  - [Linux](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on.html)
  - [Mac](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_15.html)
  - [Windows](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_34.html)
- open a Docker Quickstart Terminal
- git clone the repository for your chosen language,testFramework, eg
[Java, JUnit](https://github.com/cyber-dojo-languages/java-junit).
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  ```
- build and test the docker image for Java,JUnit by running its `pipe_build_up_test.sh` file.
The first time you run this docker will pull dependent images.
  ```bash
  cd java-junit
  ./pipe_build_up_test.sh
  ...
  PASSED:TRAFFIC_LIGHT:red:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 9",
    "duration": 2.935575839,
    ...
  }
  PASSED:TRAFFIC_LIGHT:amber:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 9sd",
    "duration": 1.744033281,
    ...
  }
  PASSED:TRAFFIC_LIGHT:green:==================================
  {
    "filename": "Hiker.java",
    "from": "6 * 9",
    "to": "6 * 7",
    "duration": 2.895220807,
    ...
  }
  ...
  ```

You can now improve the Java,JUnit docker image (built from `java-junit/docker/Dockerfile.base`)
or the Java-JUnit start point files (which live in `java-junit/start_point/`)
 or use it as a start-point for a new language+testFramework.

Here's a [complete list](https://github.com/cyber-dojo/languages/blob/master/url_list/all)
of all 100+ language+testFramework repos in cyber-dojo-languages.

Specific ways you can contribute to cyber-dojo-languages.

- convert large docker images to smaller Alpine based images.
The language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
However, if the official dockerhub image for a language is Ubuntu/Debian
then it's typically best to use that so builds get the `:latest` image.
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) Alpine based image is 121MB.
  - the [C++(g++),GoogleMock](https://github.com/cyber-dojo-languages/gplusplus-googlemock) Ubuntu based image is 1.7GB.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) Debian based image is 1.2GB.
- add a new test-framework, [testNG](https://testng.org/doc/index.html) anyone?
- reduce the [test] response time for your favourite language,test-framework
- read the starting files for you favourite language,test-framework and make them more idiomatic
- add a new language, Elm, Scala, Prolog, Lisp, SQL, ...
- suggest a [new exercise](https://github.com/cyber-dojo/start-points-exercises)
