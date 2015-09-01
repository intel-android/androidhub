[![Travis CI Status](https://travis-ci.org/intel-android/androidhub.svg?branch=master)](https://travis-ci.org/intel-android/androidhub)

### Getting Started

- ensure [node.js](http://nodejs.org) and [roots](http://roots.cx) are installed
- clone this repo and `cd` into the folder
- run `npm i` to kick off installation
- run `bower i` to install front end deps
- run `roots watch` to begin dev development

### App Overview / Folder Architecture
- `assets/`  
You'll find the js and css in here, as well as images
- `data/`  
The .yaml files found in this folder and turned into json objects and passed to jade templates. Keeps the markup dry, and puts most of the data into 1 place to maintain.
- `posts/`  
Holds authors feed posts. Folder name must match `data/authors > .yaml` file name. Posts are rendered against the `_single.jade` layout and turned into static post pages.
- `views/`  
Jade files and actual html for the site is in here.

### Contributing
Whether you want to write articles or help fix bugs, it's as easy as fork and pull request. For more information, see the [author readme](https://github.com/intel-android/androidhub/blob/master/authors_readme.md)

### Testing
`npm test`
