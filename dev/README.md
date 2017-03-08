
# Building your own cyber-dojo server from source

To get all the source:

```
mkdir cyber-dojo
cd cyber-dojo
git clone https://github.com/cyber-dojo/home.git
./home/dev/git-clone-all.sh
```

- This will create the following directory structure:

```
cyber-dojo/collector
cyber-dojo/commander
cyber-dojo/differ
cyber-dojo/docker
cyber-dojo/home
cyber-dojo/nginx
cyber-dojo/puller
cyber-dojo/ruby
cyber-dojo/runner
cyber-dojo/sinatra
cyber-dojo/storer
cyber-dojo/web_base
cyber-dojo/web
cyber-dojo/zipper
```

- Each directory holds a git repo.
- Each git repo has its own issues list on github.

To build your server from these repos, ensure docker is installed, then:

```
./cyber-dojo/home/dev/build-all.sh
```

- To bring up your server:
```
./cyber-dojo/commander/cyber-dojo up
```

- - - -

The main service repos each contain a `pipe_build_up_test.sh` script which:
- rebuilds the service's docker image
- starts a container from this server image
- shells into the server container
- runs the server tests (with coverage)
- starts a client container
- shells into the client container
- runs the client tests (with coverage)

