
<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png" alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

Home repo for [cyber-dojo](http://cyber-dojo.org).<br/>

  * Hi. I'm [Jon Jagger](http://jonjagger.blogspot.co.uk/). Welcome to cyber-dojo :-)
  * a [dojo](http://en.wikipedia.org/wiki/Dojo) is a place where martial artists meet to practice their martial art
  * a cyber-dojo is where programmers meet to [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) programming!
  * a cyber-dojo is <em>not</em> an Individual Development Environment
  * a cyber-dojo is an Interactive Dojo Environment!
  * a cyber-dojo is about [shared](http://jonjagger.blogspot.co.uk/2013/10/teams.html) [learning](http://jonjagger.blogspot.co.uk/2013/10/learning.html)
  * in a cyber-dojo you [practice](http://jonjagger.blogspot.co.uk/2013/10/practice.html) by going <em>slower</em> and focusing on [improving](http://jonjagger.blogspot.co.uk/2014/02/improving.html) rather than finishing
  * [cyber-dojo foundation](http://blog.cyber-dojo.org/2015/08/cyber-dojo-foundation.html) is a registered Scottish Charitable Incorporated Organisation
  * [learn more](http://blog.cyber-dojo.org/p/learn-more.html)

Each repo in the github cyber-dojo organization builds a single docker image.

These are the main service images:
  * [![Build Status](https://travis-ci.org/cyber-dojo/commander.svg?branch=master)](https://travis-ci.org/cyber-dojo/commander) [commander](https://github.com/cyber-dojo/commander) - receives commands from the [cyber-dojo](https://github.com/cyber-dojo/commander/blob/master/cyber-dojo) shell script
  * [![Build Status](https://travis-ci.org/cyber-dojo/nginx.svg?branch=master)](https://travis-ci.org/cyber-dojo/nginx) [nginx](https://github.com/cyber-dojo/nginx) - static image cache front end
  * [![Build Status](https://travis-ci.org/cyber-dojo/web.svg?branch=master)](https://travis-ci.org/cyber-dojo/web) [web](https://github.com/cyber-dojo/web) - main web server
  * [![Build Status](https://travis-ci.org/cyber-dojo/runner.svg?branch=master)](https://travis-ci.org/cyber-dojo/runner) [runner](https://github.com/cyber-dojo/runner) - runs an avatar's code/tests
  * [![Build Status](https://travis-ci.org/cyber-dojo/puller.svg?branch=master)](https://travis-ci.org/cyber-dojo/puller) [puller](https://github.com/cyber-dojo/puller) - pulls docker images required by runner
  * [![Build Status](https://travis-ci.org/cyber-dojo/collector.svg?branch=master)](https://travis-ci.org/cyber-dojo/collector) [collector](https://github.com/cyber-dojo/collector) - collects old docker volumes created by runner
  * [![Build Status](https://travis-ci.org/cyber-dojo/storer.svg?branch=master)](https://travis-ci.org/cyber-dojo/storer) [storer](https://github.com/cyber-dojo/storer) - stores an avatar's code/test files
  * [![Build Status](https://travis-ci.org/cyber-dojo/differ.svg?branch=master)](https://travis-ci.org/cyber-dojo/differ) [differ](https://github.com/cyber-dojo/differ) - diffs an avatar's code/test files
  * [![Build Status](https://travis-ci.org/cyber-dojo/zipper.svg?branch=master)](https://travis-ci.org/cyber-dojo/zipper) [zipper](https://github.com/cyber-dojo/zipper) - creates tgz files for download

These are base images:
  * [![Build Status](https://travis-ci.org/cyber-dojo/docker.svg?branch=master)](https://travis-ci.org/cyber-dojo/docker) [docker](https://github.com/cyber-dojo/docker) - base for commander, runner, collector
  * [![Build Status](https://travis-ci.org/cyber-dojo/ruby.svg?branch=master)](https://travis-ci.org/cyber-dojo/ruby) [ruby](https://github.com/cyber-dojo/ruby) - base for sinatra, web_base
  * [![Build Status](https://travis-ci.org/cyber-dojo/sinatra.svg?branch=master)](https://travis-ci.org/cyber-dojo/sinatra) [sinatra](https://github.com/cyber-dojo/sinatra) - base for storer, zipper, differ, docker
  * [![Build Status](https://travis-ci.org/cyber-dojo/web_base.svg?branch=master)](https://travis-ci.org/cyber-dojo/web_base) [web_base](https://github.com/cyber-dojo/web_base) - base for web

