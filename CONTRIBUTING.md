

The cyber-dojo source code is split across two github organizations.
- [cyber-dojo-languages](https://github.com/cyber-dojo-languages) contains 100+
repositories, one for each language+testFramework (eg Java,JUnit).
- [cyber-dojo](https://github.com/cyber-dojo) contains 20+ repositories, one for
each dockerized microservice that together comprise the server.

- - - -
# contributing to cyber-dojo-languages

This is the simplest way to contribute and a good way to start.
- install docker by following the instructions at the top of...
  - [Linux](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on.html)
  - [Mac](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_15.html)
  - [Windows](https://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_34.html)
- open a Docker Quickstart Terminal
- git clone the [image_builder](https://github.com/cyber-dojo-languages/image_builder) repository.
This automates the building and testing of a cyber-dojo-language repo.
```
git clone https://github.com/cyber-dojo-languages/image_builder.git
```
- git clone the repository for your chosen language,testFramework, eg
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit). This must be in a
sibling directory to image_builder directory.
```
git clone https://github.com/cyber-dojo-languages/java-junit.git
```
Here's a
[complete list](https://github.com/cyber-dojo/languages/blob/master/url_list/all)
of all 100+ language+testFramework repos in cyber-dojo-languages.
- build and test the docker image for Java,JUnit by running its pipe_build_up_test.sh file.
The first time you run this docker will pull dependent images.

```
cd java-junit
./pipe_build_up_test.sh
```
will produce output like this:
```
...
# ------------------------------------------
# assert_create_start_point
...
# ------------------------------------------
# build_image
...
# ------------------------------------------
# show_avatar_users_sample
...
# ------------------------------------------
# check_red_amber_green
# red: OK (~2.45 seconds)
# amber: OK (~1.46 seconds)
# green: OK (~1.86 seconds)
# ------------------------------------------
...
```

You can now improve the Java,JUnit docker image (built from java-junit/docker/)
or the Java-JUnit starting files (which live in java-junit/start_point/)
 or use it as a start-point for a new language+testFramework.

Specific ways you can contribute to cyber-dojo-languages.

- fix the broken Dockerfile for
[elm,test](https://github.com/cyber-dojo-languages/elm-test)

- make Scala fast enough to be usable. See
[scala-test](https://github.com/cyber-dojo-languages/scala-test)
which is built on [scala](https://github.com/cyber-dojo-languages/scala).
Can someone smart get this down to something reasonable?

- add a new language, Prolog, Lisp, SQL, ...

- add a new test-framework, [testNG](https://testng.org/doc/index.html) anyone?

- reduce the [test] response time for your favourite language,test-framework

- read the starting files for you favourite language,test-framework and make them more idiomatic

- suggest a [new exercise](https://github.com/cyber-dojo/start-points-exercises)

- convert large docker images to smaller Alpine based images.
The language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
However, if the official dockerhub image for a language is Ubuntu/Debian
then experience has shown it's typically best to use that so the nightly Travis build
gets the :latest image.
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) Alpine based image is 114MB.
  - the [C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock) Ubuntu based image is 903MB.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) Debian based image is 1.05GB.


- - - -
# contributing to cyber-dojo

- the [github issues list](https://github.com/cyber-dojo/web/issues) lives on the main web service repo.
If you fancy helping with a specific issue please add a comment to it.

- if you've tried building your own cyber-dojo from the github source repos I'd
really appreciate knowing what was easy, what was hard, and what I could do to
make it easier for you.
