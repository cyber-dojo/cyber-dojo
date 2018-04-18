
<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png"
alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

The cyber-dojo source code is split across two github organizations.
- [cyber-dojo](https://github.com/cyber-dojo) contains 10+ repositories, one for
each dockerized microservice that together comprise the server.
- [cyber-dojo-languages](https://github.com/cyber-dojo-languages) contains 100+
repositories, one for each language+testFramework (eg Java,JUnit).

- - - -

# contributing to cyber-dojo-languages
This is the simplest way to contribute and a good way to start.
- install docker by following the instructions at the top of...
  - [Linux](http://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on.html)
  - [Mac](http://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_15.html)
  - [Windows](http://blog.cyber-dojo.org/2016/10/running-your-own-cyber-dojo-server-on_68.html)
- git clone the repository for your chosen language,testFramework, eg
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit).
Here is a
[complete list](https://github.com/cyber-dojo/start-points-languages/blob/master/languages_list)
of all 100+.
- git clone the [image_builder](https://github.com/cyber-dojo-languages/image_builder) repository.
This automates the building and testing and must be in a sibling directory.
- open a Docker Quickstart Terminal
- build and test the docker image for Java,JUnit by running its pipe_build_up_test.sh file.
The first time you run this docker will pull dependent images.

```
mkdir cdlang
cd cdlang
git clone https://github.com/cyber-dojo-languages/java-junit.git
git clone https://github.com/cyber-dojo-languages/image_builder.git
cd java-junit
./pipe_build_up_test.sh
```

You can now improve the Java,JUnit docker image or use it as a start-point for a
new language+testFramework.

Here's a list of specific ways you can contribute to cyber-dojo-languages.

- fix the broken Dockerfile for
[elm,test](https://github.com/cyber-dojo-languages/elm-test)

- make Scala fast enough to be usable. See
[scala-test](https://github.com/cyber-dojo-languages/scala-test)
which is built on [scala](https://github.com/cyber-dojo-languages/scala).
Can someone smart get this down to something reasonable?

- add a new language, Prolog, Lisp, SQL, ...

- add a new test-framework

- reduce the [test] response time for your favourite language,test-framework

- make the starting files for you favourite language,test-framework more idiomatic

- suggest a [new exercise](https://github.com/cyber-dojo/start-points-exercises)

- the language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
Converting Ubuntu/Debian based images to smaller Alpine based images would be nice.
For example
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) Alpine based image is 114MB.
  - the [C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock) Ubuntu based image is 903MB.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) Debian based image is 1.05GB.
However, that if the official dockerhub image for a language is Ubuntu/Debian
then experience has shown it's best to use that so the nightly Travis build
gets the :latest image.

- - - -

# contributing to cyber-dojo

[Instructions for downloading the git repos and building everything from source](https://github.com/cyber-dojo/cyber-dojo/tree/master/dev)

- the [github issues list](https://github.com/cyber-dojo/web/issues) lives on the main web service repo.
If you fancy helping with a specific issue please add a comment to it.

- if you've tried building your own cyber-dojo from the github source repos I'd
really appreciate knowing what was easy, what was hard, and what I could do to
make it easier for you.
