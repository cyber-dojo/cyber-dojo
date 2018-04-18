
<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png"
alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

The cyber-dojo source code is split across two github organizations.
- [cyber-dojo](https://github.com/cyber-dojo) This contains ~10 repositories, one for
each of the dockerized microservices that together comprise the main web server.
- [cyber-dojo-languages](https://github.com/cyber-dojo-languages) This contains over 100
respositories, one for each dockerized microservice for a given language+testFramework.

# contributing to cyber-dojo-languages
This is the simplest way to contribute and a good way to start.
- install docker as detailed [here](http://blog.cyber-dojo.org/2017/09/running-your-own-cyber-dojo-server.html).
On Windows/Mac note that these instructions specify to install DockerToolbox.
- git clone the [image_builder](https://github.com/cyber-dojo-languages/image_builder) repository.
This automates the building and testing.
- git clone the repository for the language,testFramework, eg
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit).
- build and test the docker image for Java,JUnit by running its pipe_build_up_test.sh file.
The first time you run this it will need to docker pull dependent images.

```
mkdir cdlang
cd cdlang
git clone https://github.com/cyber-dojo-languages/image_builder
git clone https://github.com/cyber-dojo-languages/java-junit.git
cd java-junit
./pipe_build_up_test.sh
```

You can now improve the Java,JUnit docker image or use it as a start-point for a
new language+testFramework.

Here's a list of specific ways you can contribute to cyber-dojo-languages.

- fix the broken Dockerfile for
[elm+test](https://github.com/cyber-dojo-languages/elm-test)

- add Scala. I tried this ages ago; the response time was so long it was not useable (~15 seconds).
Someone smarter than me can surely get this down to something reasonable.

- add new language+testFrameworks, Prolog, Lisp, SQL, ...

- help reduce the [test] response time for the test-framework runs, eg
  - [C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock)
  - [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit)

- [new exercises](https://github.com/cyber-dojo/start-points-exercises)

- the language+testFramework images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
Converting Ubuntu/Debian based images to smaller Alpine based images
where appropriate would be nice.
For example
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) Alpine based image is 114MB.
  - the [C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock) Ubuntu based image is 903MB.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) Debian based image is 1.05GB.


# contributing to cyber-dojo

[Instructions for downloading the git repos and building everything from source](https://github.com/cyber-dojo/cyber-dojo/tree/master/dev)

- the [github issues list](https://github.com/cyber-dojo/web/issues) lives on the main web service repo.
If you fancy helping with a specific issue please add a comment to it.

- if you've tried building your own cyber-dojo from the github source repos I'd
really appreciate knowing what was easy, what was hard, and what I could do to
make it easier for you.
