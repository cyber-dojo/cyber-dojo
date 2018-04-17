
[Instructions for downloading the git repos and building everything from source](https://github.com/cyber-dojo/cyber-dojo/tree/master/dev)

- the [github issues list](https://github.com/cyber-dojo/web/issues) lives on the main web service repo.
If you fancy helping with a specific issue please add a comment to it.

- if you've tried to build your own cyber-dojo from the github source repos
I'd really appreciate knowing what was easy, what was hard,
and what I could do to make it easier for you.

- help reduce the [test] response time for some of the test-frameworks.
For example,
[C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock),
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit)

- fix the broken Dockerfile for
[elm+test](https://github.com/cyber-dojo-languages/elm-test)

- add Scala. I tried this ages ago; the response time was so long it was not useable (~15 seconds).
Someone smarter than me can surely get this down to something reasonable.

- add new language+testFrameworks, Prolog, Lisp, SQL, ...

- the [Dockerfiles](https://docs.docker.com/engine/reference/builder/) used
to create the language start-point images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/) or
[Debian](https://www.debian.org/).
For example, the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit)
Alpine based image is 114MB.
For example, the [C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock)
Ubuntu based image is 903MB.
For example, the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest)
Debian based image is 1.05GB.
Converting Ubuntu/Debian based images to smaller Alpine based images
where appropriate would be nice.

- [new exercises](https://github.com/cyber-dojo/start-points-exercises)


