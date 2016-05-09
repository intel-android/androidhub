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

if [[ -f public/old-index.html ]]; then
  cp public/old-index.html public/index.html
fi

cp -R public/*.html public/en
cp -R public/posts/* public/en/posts

if [[ -d public/android-field-guide ]]; then
  cp -R public/android-field-guide/*.html public/en/android-field-guide
fi

# Something may have gone wrong, as the “public” folder contains another “public” folder, therefore the entire site is included twice.
rm -rf public/public
rm -rf public/en/public

# Can we move file reviewer_readme.html out of the /en/ folder since it will not be localized? If not, we will ignore it.
rm -f public/en/reviewer_readme.html

# File redirector.html should not be in the /en/ folder.
rm -f public/en/redirector.html


# For links in the HTML files to work for all languages without any changes after translation:
# use root-relative paths for links to assets.
# use relative (not root-relative) paths to link to other HTML files.

if [ "$(uname)" == "Darwin" ]; then
  find -X public/en -name '*.html' | xargs sed -i -e 's/a href=\"\//a href=\"\/en\//g'
  find -X public/en -name '*.html-e' | xargs rm -f    
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  find public/en -name '*.html' | xargs sed -i -e 's/a href=\"\//a href=\"\/en\//g'
  find public/en -name '*.html-e' | xargs rm -f
fi

# replace index with one that redirects to the local version
cp public/index.html public/old-index.html
cp public/redirector.html public/index.html

echo "waiting for xargs..."
sleep 10
echo "done"


# delete original .html files
rm -rf public/posts/**/*.html
rm -f public/authors.html
rm -f public/about.html
rm -f public/commit.html
rm -f public/feed.html
rm -f public/reviewer_readme.html
