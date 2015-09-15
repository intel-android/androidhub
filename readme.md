[![Travis CI Status](https://travis-ci.org/intel-android/androidhub.svg?branch=master)](https://travis-ci.org/intel-android/androidhub)

### Required Tools
> These tools need to be installed on your machine, hopefully they're already there. We also expect you to have a Github account, and have used CLI tools a bit.

- [Node/NPM](https://nodejs.org/)
- [Roots](http://roots.cx/) `npm i roots -g`
- [Bower](http://bower.io/) `npm i bower -g`
- Git

### Getting Started
- Fork this repo
- Clone your fork of this this repo and `cd` into the folder
- run `npm i && bower i` to kick off installation of project and front end deps
- run `roots watch` to begin dev development

### Author App Overview / Folder Architecture
- `data/`  
Each .yaml files found in this folder is turned into a json object and passed to jade templates.
- `posts/`  
Holds authors posts/articles. Each author has their own folder which holds their images and articles.

### Contributing!?
Whether you want to write articles or help fix bugs, it's as easy as fork and pull request. For more information, see the [author readme](https://github.com/intel-android/androidhub/blob/master/authors_readme.md).

### Testing
`npm test`
