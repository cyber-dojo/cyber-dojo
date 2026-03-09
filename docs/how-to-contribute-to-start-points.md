
:+1::tada: Thank you :tada::+1:

Please email [support@cyber-dojo.org](mailto:support@cyber-dojo.org 'Supporting cyber-dojo') if you have any questions or can offer support,

# Contributing to cyber-dojo's Language & Test-Framework (LTF) start-points

* [Ways you can help](#ways-you-can-help)
  * [Speed up a slow LTF](#speed-up-a-slow-ltf)
  * [Become the owner of one or more LTFs](#become-the-owner-of-one-or-more-ltfs)
  * [Other ways you can contribute to the LTFs](#other-ways-you-can-contribute-to-the-ltfs)
* [What you need to know ](#what-you-need-to-know)
  * [Top level repo structure](#top-level-repo-structure)
  * [The manifest.json file](#the-manifestjson-file)
* [How to...](#how-to)
  * [How to build the image](#how-to-build-the-image)
  * [How to test the start-point](#how-to-test-the-start-point)
* [A typical development loop](#a-typical-development-loop)

***

## Ways you can help

### Speed up a slow LTF

This is the most helpful way you can contribute to the LTFs.

For example, the initial start-point for `csharp-nunit` used `dotnet` commands
which took ~8 seconds (which is a long time for one trivial test). 
Some great work from a contributor (thanks Martin) reduced this to ~2 seconds.
The obvious/canonical/documented commands can be _slow_ for two main reasons:
- Each cyber-dojo [test] run is 100% stateless - it is executed in a _new_ container and cannot, for example, take advantage of caching from previous runs.
- Default language installs tend to be tailored for large projects, not very small ones that don't need or want complicated extra bells and whistles.

Please email [support@cyber-dojo.org](mailto:support@cyber-dojo.org 'Speed up a slow LTF') if you can help.

### Become the owner of one or more LTFs

Take on responsibility for upgrading it periodically.
For example, as new versions of the language or test-framework come out. 
This is typically very easy - it's just that there are a _lot_ of start-points.

Please email [support@cyber-dojo.org](mailto:support@cyber-dojo.org 'Becoming the owner of one or more LTFs') if you can help.

### Other ways you can contribute to the LTFs

- add a **new test-framework**, [testNG](https://testng.org/doc/index.html) anyone?
- make some existing `start_point/` source files **more idiomatic** 
- add a **coverage report** to your favourite language-testFramework.
  Please write the coverage report to a file called `report/coverage.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
- add a **lint report** to your favourite language-testFramework.
  Please write the lint report to a file called `report/style.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).

Please email [support@cyber-dojo.org](mailto:support@cyber-dojo.org 'Other ways you can contribute to the LTFs') if you can help.

## What you need to know 

### Top level repo structure

The cyber-dojo Language & Test-Framework start-point repos all live in the [cyber-dojo-start-points](https://github.com/cyber-dojo-start-points) GitHub organization.
Each repository defines the *starting files* and associated details for _one_ Language & Test-Framework. For example:
- [csharp-nunit](https://github.com/cyber-dojo-start-points/csharp-nunit)
- [python-pytest](https://github.com/cyber-dojo-start-points/python-pytest)
- [java-junit](https://github.com/cyber-dojo-start-points/java-junit)

### The manifest.json file

Each start-point repository (eg [java-junit](https://github.com/cyber-dojo-start-points/java-junit)) holds a file called `start_point/manifest.json`.
For example:
  ```json
  {
    "display_name": "Java 25.0.2, JUnit 6.0.3",
    "image_name":"ghcr.io/cyber-dojo-languages/java_junit:7aa5992",
    "visible_filenames": [
      "HikerTest.java",
      "Hiker.java",
      "cyber-dojo.sh"
    ],
    "rag_lambda": "red_amber_green.rb",
    ...      
  }
  ```
  
- `display_name`: the text for the start-point when you are setting up your practice session.
- `visible_filenames`: the paths of the starting source files, relative to the `start_point` directory:
  - they always specify a file containing a function returning `6 * 9` and a test file asserting it returns `42` (start with a failing test!). 
  - the `6 * 9 == 42` structure is from Hitch Hikers Guide to the Galaxy, so the files are usually named `hiker`.
  - one of these files _must_ be `cyber-dojo.sh`. This is a bash script with the necessary commands to run the tests. Do not hard-code the filenames from `visible_filenames` into it. Use wildcards so it will continue to work when files are renamed or added in a practice session.
  - paths can include subdirs. For example, `StepDefinitions/HikerSteps.cs` which will
  appear in the browser and be honoured when `cyber-dojo.sh` runs inside the docker container.
- `image_name`: the name of the docker image`cyber-dojo.sh` run inside.
- `rag_lambda`: the name of a file (also in the `start_point` directory) containing a Ruby lambda whose:
  - input is the [`stdout`, `stderr`,`status`] of `cyber-dojo.sh` when run inside `image_name`
  - output is the string `red`, `amber`, or `green` 

## How to...

### How to build the image

The `image_name` in the `manifest.json` file is built in a
_separate_ "partner" repository in the [cyber-dojo-languages](https://github.com/cyber-dojo-start-languages/) GitHub organization. 
[Always two there are](https://www.youtube.com/watch?v=b7SjW0vFCiI).
For example, the two repos for java-junit are:
- [cyber-dojo-languages/java-junit](https://github.com/cyber-dojo-languages/java-junit) which names a docker image built in...
- [cyber-dojo-start-points/java-junit](https://github.com/cyber-dojo-start-points/java-junit)

This separation into two repositories per LTF is necessary because:
1. The `image_name` in the `manifest.json` file is tagged with the short-sha of the commit that built the image. That is not available until _after_ the commit has taken place (chicken and egg).
2. Automated custom tooling ensures the image is augmented with commands needed to satisfy cyber-dojo's runtime requirements. 

Each languages "partner" repo holds a file called `docker/Dockerfile.base`.
For example:
```Dockerfile
FROM ghcr.io/cyber-dojo-languages/java:fd1ea55
LABEL maintainer=jon@jaggersoft.com

COPY /jars/* /junit/
ENV CLASSPATH=/junit/
```

In a terminal with [Docker](https://docs.docker.com/install/) installed, build the docker image by running `pipe_build_up_test.sh` which will:

- Create `docker/Dockerfile` from `docker/Dockerfile.base`, augmented to satisfy
  the [runner's](https://github.com/cyber-dojo/runner) requirements. For example:
  - it creates a specific non-root user
  - it installs `tar` to pipe files in and out of the container.
- Build a new docker image from `docker/Dockerfile`.
- The untagged name of the image is the `image_name` entry of `docker/image_name.json`.

The image OS must be Alpine, Debian, or Ubuntu, as determined by the contents
of the FROM image's `/etc/issue` file. If there is no `etc/issue` file you
can use a custom comment. For example:
```Dockerfile
FROM ghcr.io/cyber-dojo-languages/java:fd1ea55
LABEL maintainer=jon@jaggersoft.com
# OS=Alpine
...
```

If `pipe_build_up_test.sh` succeeds, near the end of its output you will see
a message:
```
Successfully tagged to ghcr.io/cyber-dojo-languages/java_junit:2eac00c
```

This is the `image_name` you must use in the start-point's `manifest.json` file.
For example:
```json
{
    "display_name": "Java 25.0.2, JUnit 6.0.3",
    "image_name":"ghcr.io/cyber-dojo-languages/java_junit:2eac00c",
    ...
}
```

### How to test the start-point

Each start-point repo contains a `run_tests.sh` script. Run this in a terminal with [Docker](https://docs.docker.com/install/) and git installed. It will:
- run `cyber-dojo.sh` inside the docker image `image_name` from `start_point/manifest.json` three times, checking the resulting traffic-light colour (from `rag_lambda`) is:
    - `red` when the `visible_filenames` are unmodified.
    - `amber` when the `6 * 9` is modified to `6 * 9sd`.
    - `green` when the `6 * 9` is modified to `6 * 7`.
- if none of the `visible_filenames` contain the pattern `6 * 9`, (eg the language uses infix notation) you can override the red/amber/green modification patterns using an `options.json` file. See [nasm-assert](https://github.com/cyber-dojo-start-points/nasm-assert/blob/master/start_point/options.json) for an example.

Each `red`, `amber`, `green` run will print two JSON objects.

The first JSON object shows:
- `stdout`, `stderr` and `status` output by `cyber-dojo.sh`
- `outcome` the colour result of the `rag_lambda` named in `manifest.json`
- `created` shows any new files created by `cyber-dojo.sh`
- `changed` shows any existing files changed by `cyber-dojo.sh`

For example:
```json
{
  "stdout": {
    "content": [
      "Microsoft (R) Visual C# Compiler version 5.0.0-2.26075.103 (c2435c3e)\n",
      "Copyright (C) Microsoft Corporation. All rights reserved.\n",
      ...
      "Test Run Summary\n",
      "  Overall result: Passed\n",
      "  Test Count: 1, Passed: 1, Failed: 0, Warnings: 0, Inconclusive: 0, Skipped: 0\n",
      ...
    ],
    "truncated": false
  },
  "stderr": {
    "content": [
      ...
    ],
    "truncated": false
  },
  "status": "0",
  "outcome": "green",
  "log": null,
  "created": {
  },
  "changed": {
  }
}
```

The second JSON object shows:
- `runner_sha` is the commit of the runner microservice in action
- `filename`, `from`, `to` detail the edit made (no edit for initial `red` run)
- `duration` is how long `cyber-dojo.sh` took to execute
- `colour` the result of the "rag_lambda" named in `manifest.json`
- `result` is "PASSED" if the `colour` is as expected.

For example:
```json
{
  "runner_sha": "d579c7a17cc224f22b6b7db3f1e4f3421b511f00",
  "max_seconds": 15,
  "filename": "Hiker.cs",
  "from": "6 * 9",
  "to": "6 * 7",
  "duration": 3.638545877,
  "colour": "green",
  "result": "PASSED"
}
```

## A typical development loop

- In the languages repo:
  - edit `docker/Dockerfile.base`
  - rerun `pipe_build_up_test.sh`
  - note the tag of the newly built image
- In the start-points repo:
  - edit the tag for `image_name` in `start_point/manifest.json`
  - edit the files named in `visible_filenames`
  - run `run_tests.sh`, check the `duration`'s, and the correctness:
    - the `red` run is `red`
    - the `amber` run is `amber`
    - the `green` run is `green`

Please email [support@cyber-dojo.org](mailto:support@cyber-dojo.org 'Other ways you can contribute to the LTFs') if you need help.

:+1::tada: Thank you :tada::+1:
