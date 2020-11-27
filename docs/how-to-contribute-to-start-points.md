
# Contributing to cyber-dojo's start-points

:+1::tada: Thanks :tada::+1:

- The cyber-dojo language+testFramework start-point repos all live in the [cyber-dojo-start-points](https://github.com/cyber-dojo-start-points) github organzation.
- Each repository specifies the *starting files* for a language+testFramework.
- Each repository (eg [java-junit](https://github.com/cyber-dojo-start-points/java-junit)) has the same
`start_point/manifest.json` layout.
- for example:
  ```json
  {
    "image_name":"cyberdojofoundation/java_junit:97411ac",
    "visible_filenames": [
      "HikerTest.java",
      "Hiker.java",
      "cyber-dojo.sh"
    ],
    ...      
  }
  ```
- the names of the start-point source files are specified in the `visible_filenames` entry.
- they always specify a function that returns `6 * 9` and a test asserting it returns `42`.
- one of the start-point source files is always `cyber-dojo.sh`.
- `cyber-dojo.sh` runs inside a docker image whose name is specified in the `image_name` entry.


To test the start-point files run `run_tests.sh` in a terminal with [Docker](https://docs.docker.com/install/)
and git installed. It will:
- run `cyber-dojo.sh` inside the specified docker image container (three times) and check
  the resulting traffic-light colours are
    - `red` when the `visible_filenames` are unmodified.
    - `amber` when the `6 * 9` is modified to `6 * 9sd`.
    - `green` when the `6 * 9` is modified to `6 * 7`.
- if none of the `visible_filenames` contain the pattern `6 * 9`, (eg the language uses infix
  notation) you can specify the red/amber/green modifications explicitly using an `options.json`
  file. See [nasm-assert](https://github.com/cyber-dojo-start-points/nasm-assert/blob/master/start_point/options.json) for an example.
- the colour of the traffic-light is determined by passing the `[stdout,stderr,status]` results of
running `cyber-dojo.sh` to a Ruby lambda defined in the `/usr/local/bin/red_amber_green.rb` file
inside `image_name`.


Specific ways you can contribute to cyber-dojo-start-points:

- make a **faster run** (can you reduce 2.9s `duration` for Java,Junit)?
- make the `start_point/` source files **more idiomatic** for your favourite language-testFramework?
- add a **new test-framework**, [testNG](https://testng.org/doc/index.html) anyone?
- add a **coverage report** to your favourite language-testFramework.
  Please write the coverage report to a file called `report/coverage.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
- add a **lint report** to your favourite language-testFramework.
  Please write the lint report to a file called `report/style.txt`.
  For example, see [python-pytest](https://github.com/cyber-dojo-languages/python-pytest/blob/master/start_point/cyber-dojo.sh).
