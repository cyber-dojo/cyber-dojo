
# Contributing to cyber-dojo's languages

:+1::tada: Thanks :tada::+1:

- The cyber-dojo language+testFramework repos all live in the [cyber-dojo-languages](https://github.com/cyber-dojo-languages) github organzation.
- Each repository specifies a Dockerfile used to create a Docker *image*
- Each repository (eg [java-junit](https://github.com/cyber-dojo-languages/java-junit)) has the same `docker/` dir layout.


- If you want to update an **existing language-testFramework** then git clone it.
  For example [java-junit](https://github.com/cyber-dojo-languages/java-junit):
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  ```
- If you want to add a **new testFramework** to an **existing language**, clone one
  of the languages' existing testFrameworks, rename it, and modify it.
  For example, to add [testNG](https://testng.org/doc/index.html)
  ```bash
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  mv java-junit java-testng
  ...
  ```
- If you want to add a **new testFramework** for a **new language**, clone an existing language repo and one of its testFramework repos, rename them, and modify them.
  For example [java](https://github.com/cyber-dojo-languages/java) and [java-junit](https://github.com/cyber-dojo-languages/java-junit)
  ```bash
  git clone https://github.com/cyber-dojo-languages/java.git
  git clone https://github.com/cyber-dojo-languages/java-junit.git
  mv java lisp
  mv java-junit lisp-test
  ...
  ```


In a terminal with [Docker](https://docs.docker.com/install/) installed, build and test the docker image by running `pipe_build_up_test.sh` which will:

- Create `docker/Dockerfile` from `docker/Dockerfile.base`, augmented to satisfy
  the [runner's](https://github.com/cyber-dojo/runner) requirements.
- Build a new docker image from `docker/Dockerfile`.
- The name of the image is the `image_name` entry of `docker/image_name.json`.


Specific ways you can contribute to cyber-dojo-languages:

- add a **new test-framework**, [testNG](https://testng.org/doc/index.html) anyone?
- add a **new language**, Elm, Lisp, Scala, Racket, Unison, ...
- make a `Dockerfile.base` **more idiomatic**?
- make a **faster docker build**?
- make a **smaller docker image**?
The language+testFramework images are based on either
[Alpine](https://alpinelinux.org/) or
[Debian](https://www.debian.org/) or
[Ubuntu](https://www.ubuntu.com/).
Changing a Debian/Ubuntu image to Alpine would be a big help.
  - the [Java,JUnit](https://github.com/cyber-dojo-languages/java-junit) `Alpine` based image is ~**120MB**.
  - the [Python,pytest](https://github.com/cyber-dojo-languages/python-pytest) `Debian` based image is ~**1.2GB**.
  - the [C++(g++),GoogleMock](https://github.com/cyber-dojo-languages/gplusplus-googlemock) `Ubuntu` based image is ~**1.7GB**.
