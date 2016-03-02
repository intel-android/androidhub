#!/bin/bash

# cleanup
rm -rf public/en/posts
rm -rf public/en/*.html

# Create an /en/ folder in the root 
mkdir -p public/en/posts
mkdir -p public/en/android-field-guide

# clean out all images in posts
rm -rf public/posts/**/library

# and move the following items into the /en/ folder:
# android-field-guide
# posts (folder)
# index.html
# 404.html
# about.html
# authors.html
# commit.html
# feed.html

cp -R public/*.html public/en
cp -R public/posts/* public/en/posts
cp -R public/android-field-guide/*.html public/en/android-field-guide

# For links in the HTML files to work for all languages without any changes after translation:
# use root-relative paths for links to assets.
# use relative (not root-relative) paths to link to other HTML files.

find -X public/en -name '*.html' | xargs sed -i -e 's/\<a href=\"\//\<a href=\"\/en\//g'
find -X public/en -name '*.html-e' | xargs rm -f

# replace index with one that redirects to the local version
cp public/redirector.html public/index.html
