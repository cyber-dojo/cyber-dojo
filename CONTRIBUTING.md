
Things that would help:

1) If you've tried to build your own cyber-dojo from the github source repos
(and maybe do some development) I'd really appreciate knowing what worked,
what didn't, was easy, what was hard, and what I could do to make it easier
for you.

2) The [Dockerfiles](https://docs.docker.com/engine/reference/builder/) used
to create the language start-point images are based on either
[Alpine Linux](https://alpinelinux.org/) or
[Ubuntu](https://www.ubuntu.com/).
For example, the [C,assert] Alpine based image is 96MB.
For example, the [C++ (clang),assert] Ubuntu based image is 1.7GB.
Converting Ubuntu based images to smaller Alpine based images would be a big help.

3) Many cyber-dojo.sh files are ripe for improvement.
For example, some of the C/C++ test-framework, eg
[C++ (clang),GoogleMock](https://github.com/cyber-dojo-languages/clangplusplus-googlemock)
do a crude [make --always-make] when running make from their
[cyber-dojo.sh file](https://github.com/cyber-dojo-languages/clangplusplus-googlemock/blob/master/start_point/cyber-dojo.sh).
This is because when the makefiles were written the runner was stateless.
But the [runner](https://github.com/cyber-dojo/runner_stateful) can now be stateful
so dropping the --always-make and editing the makefiles might make the tests
run quicker.

4) [New exercises](https://github.com/cyber-dojo/start-points-exercises)

5) Figure out how to fix the broken Dockerfile for
[javascript+cucumber](https://github.com/cyber-dojo-languages/javascript-cucumber)

