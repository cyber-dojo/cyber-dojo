
Things that would help:

1) If you've tried to build your own cyber-dojo from the source
(and maybe do some development) I'd really appreciate knowing what
was easy, what was hard, and what I could do to make it easier for you.

2) Many cyber-dojo.sh files are ripe for improvement.
For example, some of the C/C++ test-framework
[start-points](https://github.com/cyber-dojo/start-points-languages)
do a crude [make --always-make].
This is because when the makefiles were written the runner was stateless.
But the [runner](https://github.com/cyber-dojo/runner) is now stateful
so dropping the --always-make and editing the makefiles might make the tests
run quicker.

3) The [Dockerfiles](https://github.com/cyber-dojo/Dockerfiles) used
to create the language start-point images are based on either
[Alpine Linux](https://alpinelinux.org/)
[Ubuntu](https://www.ubuntu.com/).
Converting Ubuntu based images to Alpine based images would be a big help.
