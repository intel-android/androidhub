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
var files_path = path.join('posts', '*', '*.jade');
console.log(files_path);
var files = glob.sync(path.normalize(files_path));

var object = {};
var formatter = "";
// var isWindows = /^win/.test(process.platform);
// if (isWindows) {
//   formatter = '\'{%n  \"commit\": \"%H\",%n  \"author\": \"%an <%ae>\",%n  \"date\": \"%ad\",%n  \"message\": \"%s\"%n}\'';
// } else {
// }

formatter = '{%n  ^@^commit^@^: ^@^%H^@^,%n  ^@^author^@^: ^@^%an <%ae>^@^,%n  ^@^date^@^: ^@^%ad^@^,%n  ^@^message^@^: ^@^%s^@^%n}';

for(var i=0; i<files.length; i++) {
  var file = path.normalize(files[i]);

  console.log(file);

  var command = 'git --no-pager log -1 --pretty=format:\'' + formatter + '\' -- ' + file;
  console.log(command);
  var git = exec(command, {async: false, silent: true});
  var output = git.output;
  var out = ("" + output).replace(/"/gm, '\\"').replace(/\^@\^/gm, '"');
  object[file] = JSON.parse(out);
}

var content = JSON.stringify(object);

content.to(path.normalize(path.join('public', 'posts-git.json')));
exit(0);
