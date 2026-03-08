
# Contributing to cyber-dojo's Language & Test-Framework (LTF) start-points

:+1::tada: Thanks :tada::+1:

The cyber-dojo Language & Test-Framework start-point repos all live in the [cyber-dojo-start-points](https://github.com/cyber-dojo-start-points) GitHub organzation.

Each repository defines the *starting files* and associated details for _one_ Language & Test-Framework. For example:
- [csharp-nunit](https://github.com/cyber-dojo-start-points/csharp-nunit)
- [python-pytest](https://github.com/cyber-dojo-start-points/python-pytest)
- [java-junit](https://github.com/cyber-dojo-start-points/java-junit)

## The two best ways you can contribute 

### 1. Speed up a slow LTF

For example, the initial start-point for `csharp-nunit` used `dotnet` commands
which took ~8 seconds (which is a long time for one trivial test). 
Some great work from a contributor (thanks Martin) reduced this to ~2 seconds.
It is not unusual for the obvious/canonical/documented commands to be _slooow_. 
There are two main reasons for this:
- Each cyber-dojo [test] run is 100% stateless - it is executed in a _new_ container and cannot, for example, take advantage of caching from previous runs.
- Default language installs tend to be tailored for large projects, not very small ones that don't need or want complicated extra bells and whistles.

### 2. Become the 'owner' of one or more LTFs

Take on responsibility for upgrading it periodically.
For example, as new versions of the language or test-framework come out. 
This is typically very easy - it's just that there are a _lot_ of start-points.

## Other ways you can contribute to LTFs

- add a **new test-framework**, [testNG](https://testng.org/doc/index.html) anyone?
- make some existing `start_point/` source files **more idiomatic** 
- add a **coverage report** to your favourite language-testFramework.
  Please write the coverage report to a file called `report/coverage.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
- add a **lint report** to your favourite language-testFramework.
  Please write the lint report to a file called `report/style.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).

## Details you need to know 

Each repository (eg [java-junit](https://github.com/cyber-dojo-start-points/java-junit)) holds a file called `start_point/manifest.json`.
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
  
- `display_name` specifies the text for the start-point when you are setting up your practice session.
- `visible_filenames` specifies the _names_ of the starting source files (which must be present in the `start_point` directory):
  - they always specify a file containing a function returning `6 * 9` and a test file asserting it returns `42` (start with a failing test!). This `6 * 9 == 42` structure is from Hitch Hikers Guide to the Galaxy, so the files are usually named `hiker`.
  - one of these files must be `cyber-dojo.sh`. This is a bash script with the necessary command(s) to run the tests. Do not hard-code the filenames from `visible_filenames` into it. Instead use wildcards so it will continue to work when the files are renamed or added in an actual practice session.
- `image_name` specifies the name of the docker image inside which `cyber-dojo.sh` runs.
- `rag_lambda` specifies the name of a file (also in the `start_point` directory) containing a Ruby lambda whose output is `red`, `amber`, or `green` and whose input is [`stdout`, `stderr`,`status`] of `cyber-dojo.sh` when it is run inside `image_name`.

For each LTF, there is always a _separate_ "partner" repository in the [cyber-dojo-languages](https://github.com/cyber-dojo-start-languages/) GitHub organization, whose job is to build `image_name`. 
For example, java-junit's two repos are:
- [cyber-dojo-start-points/java-junit](https://github.com/cyber-dojo-start-points/java-junit) which names a docker image buiult in...
- [cyber-dojo-languages/java-junit](https://github.com/cyber-dojo-languages/java-junit)

This separation is necessary because:
1. Automated custom tooling ensures the image's Dockerfile is augmented with commands needed to satisfy cyber-dojo's runtime requirements. For example it must have a designated non-root user.
2. The `image_name` in the `manifest.json` file is tagged with the short-sha of the commit that built the image. That is not available until _after_ the commit has taken place (chicken and egg).


## How you test your contribution

Each start-point repo contains the script `run_tests.sh`. Run this in a terminal with [Docker](https://docs.docker.com/install/) and git installed. It will:
- run `cyber-dojo.sh` inside the specified docker image container three times, checking
  the resulting traffic-light colour (from `rag_lambda`) is:
    - `red` when the `visible_filenames` are unmodified.
    - `amber` when the `6 * 9` is modified to `6 * 9sd`.
    - `green` when the `6 * 9` is modified to `6 * 7`.
- if none of the `visible_filenames` contain the pattern `6 * 9`, (eg the language uses infix notation) you can specify the red/amber/green modifications explicitly using an `options.json` file. See [nasm-assert](https://github.com/cyber-dojo-start-points/nasm-assert/blob/master/start_point/options.json) for an example.

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
      "\n",
      "Runtime Environment\n",
      "   OS Version: Alpine Linux v3.22\n",
      "  Runtime: .NET 10.0.3\n",
      "\n",
      "Test Files\n",
      "    dojo.dll\n",
      "\n",
      "\n",
      "Run Settings\n",
      "    DisposeRunners: True\n",
      "    WorkDirectory: /sandbox\n",
      "    NumberOfTestWorkers: 10\n",
      "\n",
      "Test Run Summary\n",
      "  Overall result: Passed\n",
      "  Test Count: 1, Passed: 1, Failed: 0, Warnings: 0, Inconclusive: 0, Skipped: 0\n",
      "  Start time: 2026-03-08 18:08:31Z\n",
      "    End time: 2026-03-08 18:08:32Z\n",
      "    Duration: 0.122 seconds\n",
      "\n",
      "Results (nunit3) saved as TestResult.xml\n"
    ],
    "truncated": false
  },
  "stderr": {
    "content": [
      "\n",
      "real\t0m3.043s\n",
      "user\t0m2.014s\n",
      "sys\t0m1.142s\n"
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
- `filename`, `from`, `to` detail the auto edit made (no edit for initial `red` run)
- `duration` is how long `cyber-dojo.sh` took to execute
- `colour` the colour result of the "rag_lambda" named in `manifest.json`
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


