
// This script is curl'd in several .travis.yml files to
// trigger the .travis.yml files in dependent git repos
// (after [docker push]'ing a docker image to dockerhub).

// Dependent git repos are named in the argv command line.
// eg $ node trigger-build.js cyber-dojo/web

// I do NOT run this in .travis.yml's after_success: section
// because when commands in the after_success: section fail
// they do NOT fail the travis build.
// https://github.com/travis-ci/travis-ci/issues/758

// Relies on Travis environment variable GITHUB_TOKEN being set...
//
// 1. Create the personal access token on github
//    o) Click your icon on the top-right and click [Settings] entry
//    o) Click [Personal access tokens] link on the left
//    o) Click [Generate new token] button
//    o) Select your permissions (for Travis, all you need is public_repo)
//    o) Once created, copy the token to your clipboard
//
// 2. Configure Travis to expose this token securely to this script.
//    o) Click [More options] on the top right and select [Settings]
//    o) Enter a new environment variable Name = GITHUB_TOKEN
//    o) In the Value field, paste in your token from step 1
//    o) Ensure [Display value in build log] is showing OFF
//    o) Click [Add] on the right
//
// This file is curl'd by several cyber-dojo repos' .travis.yml file.
//
// Kudos to...
// http://kamranicus.com/blog/2015/03/29/triggering-a-travis-build-programmatically/
// http://kamranicus.com/blog/2015/02/26/continuous-deployment-with-travis-ci/

// Use: node trigger-build.js [REPO]
// eg
//      $ npm install travis-ci
//      $ export NODE_PATH=$(npm config get prefix)
//      $ node trigger-build.js cyber-dojo-languages/python-3.6.1

var Travis = require('travis-ci');

var travis = new Travis({
  version: '2.0.0',
  headers: { 'User-Agent': 'Travis/1.0' }
});

var exit = function(call,error,response) {
  console.error('ERROR:travis.' + call + 'function(error,response) { ...');
  console.error('   error:' + error);
  console.error('response:' + JSON.stringify(response, null, '\t'));
  process.exit(1);
};

travis.authenticate({ github_token: process.env.GITHUB_TOKEN }, function(error,response) {
  var repos = process.argv.slice(2);
  if (error) { exit('authenticate({...}, ', error, response); }
  repos.forEach(function(repo) {
    var parts = repo.split('/');
    var name = parts[0];
    var tag = parts[1];
    console.log('TRIGGERING dependent repo ' + repo);
    travis.repos(name, tag).builds.get(function(error,response) {
      if (error) { exit('repos(' + name + ',' + tag + ').builds.get(', error, response); }
      travis.requests.post({ build_id: response.builds[0].id }, function(error,response) {
        if (error) { exit('requests.post({...}, ', error, response); }
        console.log(repo + ':' + response.flash[0].notice);
      });
    });
  });
});
