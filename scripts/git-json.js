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

for(var file in files) {
  console.log(file);

  var formatter = '"\"$f\": {%n  \"commit\": \"%H\",%n  \"author\": \"%an <%ae>\",%n  \"date\": \"%ad\",%n  \"message\": \"%s\"%n}"';
  var output = exec('git --no-pager log -1 --pretty=format:' + formatter + ' ' + file, {async: false});
  json.push(output);
}

console.log(json);

json.join(',').to('public/posts-git.json');
exit(0);
