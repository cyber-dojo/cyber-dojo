
Things that would help:

1) If you've tried to build your own cyber-dojo from the github source repos
(and maybe do some development) I'd really appreciate knowing what worked,
what didn't, was easy, what was hard, and what I could do to make it easier
for you.

2) Help reduce the [test] response time for some of the C/C++ test-frameworks.
For example,
[C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock)
does a crude [make --always-make] in its
[cyber-dojo.sh file](https://github.com/cyber-dojo-languages/clangplusplus-googlemock/blob/master/start_point/cyber-dojo.sh).
This is because when the makefiles were written the runner was stateless.
But there is now a  [stateful runner](https://github.com/cyber-dojo/runner)
so dropping the --always-make, and editing the makefile appropriately should help.

3) Help reduce the [test] response time for Java test-frameworks.
For example,
[Java,JUnit](https://github.com/cyber-dojo-languages/java-junit)
has a crude
[cyber-dojo.sh file](https://github.com/cyber-dojo-languages/java-junit/blob/master/start_point/cyber-dojo.sh)
which starts with [rm -f *.class] and can surely be improved.

4) The [Dockerfiles](https://docs.docker.com/engine/reference/builder/) used
to create the language start-point images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/).
For example, the [C,assert] Alpine based image is 96MB.
For example, the [C++ (clang),assert] Ubuntu based image is 1.7GB.
Converting Ubuntu based images to smaller Alpine based images would be nice.

5) [New exercises](https://github.com/cyber-dojo/start-points-exercises)

6) Figure out how to fix the broken Dockerfile for
[javascript+cucumber](https://github.com/cyber-dojo-languages/javascript-cucumber)

7) Figure out how to fix the broken Dockerfile for
[elm+test](https://github.com/cyber-dojo-languages/elm-test)

