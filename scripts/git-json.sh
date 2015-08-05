#!/usr/bin/env bash

# Use this one-liner to produce a JSON literal from the Git log:

#!/bin/bash
FILES=$@
arrFILES=(${FILES// / })
last=${arrFILES[-1]}

echo "{"
for f in $FILES
do
  git --no-pager log -1 --pretty=format:"\"$f\": {%n  \"commit\": \"%H\",%n  \"author\": \"%an <%ae>\",%n  \"date\": \"%ad\",%n  \"message\": \"%s\"%n}" $f

  if [[ "$f" != "$last" ]]
  then
    echo ","
  fi
  # take action on each file. $f store current file name
done
echo ""
echo "}"
