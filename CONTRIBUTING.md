
# Contributing

:+1::tada: Thanks for thinking about contributing! :tada::+1:

There is a cyber-dojo [Project Board](https://github.com/orgs/cyber-dojo/projects/3/views/1)  

- server
  - The [cyber-dojo](https://github.com/cyber-dojo) Org contains 10+ git repositories, one for each microservice that together comprise the server. For example:
    - [web](https://github.com/cyber-dojo/web) UX for the edit/review pages, Ruby on Rails
    - [dashboard](https://github.com/cyber-dojo/dashboard) UX for the group dashboard, Ruby Sinatra
    - [differ](https://github.com/cyber-dojo/differ) API to diff two sets of files, Ruby Sinatra
    - [runner](https://github.com/cyber-dojo/runner) API to runs the tests, docker-in-docker, Ruby Sinatra
    - [saver](https://github.com/cyber-dojo/saver) API for Group/Kata model+persistence (using git) API, Ruby Sinatra 
  - [Contribute to the server](https://github.com/cyber-dojo/cyber-dojo/blob/master/docs/how-to-contribute-to-server.md)

- language/test-frameworks
  - each language/test-frameworks, such as `Java 21, JUnit 5`, is split into two parts, the docker image, and the starting source-files.
    - The [cyber-dojo-languages](https://github.com/cyber-dojo-languages) Org contains 80+ git repositories, one for each language+testFramework's `docker image`. For example:
      - [Java, JUnit](https://github.com/cyber-dojo-languages/java-junit)
      - [Python, pytest](https://github.com/cyber-dojo-languages/python-pytest)
      - each repo contains the Dockerfile and script to build the image.
    - [Contribute to the language/test-framework images](https://github.com/cyber-dojo/cyber-dojo/blob/master/docs/how-to-contribute-to-languages.md)
 
    - The [cyber-dojo-start-points](https://github.com/cyber-dojo-start-points) Org contains 80+ git repositories, one for each language+testFramework's `starting source-files`. For example:
      - [Java, JUnit](https://github.com/cyber-dojo-start-points/java-junit)
      - [Python, pytest](https://github.com/cyber-dojo-start-points/python-pytest)
      - each repo contains the initial source files (typically one source file and one test file) and the name of the docker image they run inside.
    - [Contribute a language/test-framework start-points](https://github.com/cyber-dojo/cyber-dojo/blob/master/docs/how-to-contribute-to-start-points.md)

- exercises
  - The [exercises-start-points](https://github.com/cyber-dojo/exercises-start-points) repo in the cyber-dojo Org holds the 50+ exercises. For example:
    - [Fizz Buzz](https://github.com/cyber-dojo/exercises-start-points/tree/main/start-points/Fizz_Buzz)
    - [Print Diamond](https://github.com/cyber-dojo/exercises-start-points/tree/main/start-points/Print_Diamond)
  - [Contribute to the exercises](https://github.com/cyber-dojo/exercises-start-points/blob/main/docs/contributing.md)

- custom-exercises
  - The [custom-start-points](https://github.com/cyber-dojo/custom-start-points) repo in the cyber-dojo Org holds the custom exercises. For example:
    - [Tennis](https://github.com/cyber-dojo/custom-start-points/tree/main/start-points/Tennis)
    - [Yahtzee](https://github.com/cyber-dojo/custom-start-points/tree/main/start-points/Yahtzee)
  - [Contribute to the custom-exercises](https://github.com/cyber-dojo/custom-start-points/blob/main/docs/contributing.md)
