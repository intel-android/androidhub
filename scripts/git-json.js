//    "posts-git-log": "mkdir -p public && touch public/posts-git.json && ./scripts/git-json.sh posts/*/*.jade > public/posts-git.json",
require('shelljs/global');
var glob = require('glob');

if (!which('git')) {
  echo('Sorry, this script requires git');
  exit(1);
}

mkdir('-p', 'public');
// #!/usr/bin/env bash
//
// # Use this one-liner to produce a JSON literal from the Git log:
//
// #!/bin/bash
// FILES=$@
// arrFILES=(${FILES[@]})
// length=${#arrFILES[@]}
// last=${arrFILES[$length-1]}
//
// echo "{"
// for f in $FILES
// do
//   git --no-pager log -1 --pretty=format:"\"$f\": {%n  \"commit\": \"%H\",%n  \"author\": \"%an <%ae>\",%n  \"date\": \"%ad\",%n  \"message\": \"%s\"%n}" $f
//
//   if [[ "$f" != "$last" ]]
//   then
//     echo ","
//   fi
//   # take action on each file. $f store current file name
// done
// echo ""
// echo "}"

var json = [];
var files = glob.sync('posts/*/*.jade');

var object = {};
for(var i=0; i<files.length; i++) {
  var file = files[i];
  echo(file);

  var formatter = '"{%n  \\"commit\\": \\"%H\\",%n  \\"author\\": \\"%an <%ae>\\",%n  \\"date\\": \\"%ad\\",%n  \\"message\\": \\"%s\\"%n}"';
  var command = 'git --no-pager log -1 --pretty=format:' + formatter + ' ' + file;
  echo(command);
  var git = exec(command, {async: false, silent: true});
  object[file] = JSON.parse(git.output);
}

var content = JSON.stringify(object);

echo(content);

content.to('public/posts-git.json');
exit(0);
