//    "posts-git-log": "mkdir -p public && touch public/posts-git.json && ./scripts/git-json.sh posts/*/*.jade > public/posts-git.json",
require('shelljs/global');
var glob = require('glob');
var path = require('path');

if (!which('git')) {
  echo('Sorry, this script requires git');
  exit(1);
}

mkdir('-p', 'public');
var json = [];
var files = glob.sync(path.normalize('posts/*/*.jade'));

var object = {};
for(var i=0; i<files.length; i++) {
  var file = files[i];
  var formatter = '"{%n  \\"commit\\": \\"%H\\",%n  \\"author\\": \\"%an <%ae>\\",%n  \\"date\\": \\"%ad\\",%n  \\"message\\": \\"%s\\"%n}"';
  var command = 'git --no-pager log -1 --pretty=format:' + formatter + ' ' + file;
  console.log(command);
  var git = exec(command, {async: false, silent: true});
  object[file] = JSON.parse(git.output);
}

var content = JSON.stringify(object);

content.to('public/posts-git.json');
exit(0);
