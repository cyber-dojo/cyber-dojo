
[Instructions for downloading the git repos and building everything from source](https://github.com/cyber-dojo/cyber-dojo/tree/master/dev)?

- [github issues list](https://github.com/cyber-dojo/web/issues) lives on the main web service repo.
If you fancy helping with a specific issue please add a comment to it.

- If you've tried to build your own cyber-dojo from the github source repos
I'd really appreciate knowing what worked, what didn't, was easy, what was hard,
and what I could do to make it easier for you.

- Help reduce the [test] response time for some of the C/C++ test-frameworks.
For example,
[C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock)

- Help reduce the [test] response time for Java test-frameworks.
For example,
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit)
has a crude
[cyber-dojo.sh file](https://github.com/cyber-dojo-languages/java-junit/blob/master/start_point/cyber-dojo.sh)
which starts with [rm -f *.class] and can surely be improved.

- Figure out how to fix the broken Dockerfile for
[elm+test](https://github.com/cyber-dojo-languages/elm-test)

- Add Scala. I tried this ages ago; the response time was so long it was not useable (~15 seconds).
Someone smarter than me can surely get this down to something reasonable.

- Add new language+testFrameworks, Prolog, Lisp, ...

- The [Dockerfiles](https://docs.docker.com/engine/reference/builder/) used
to create the language start-point images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/).
For example, the [C,assert] Alpine based image is 96MB.
For example, the [C++ (clang),assert] Ubuntu based image is 1.7GB.
Converting Ubuntu based images to smaller Alpine based images would be nice.

- [New exercises](https://github.com/cyber-dojo/start-points-exercises)


