axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
dynamic         = require 'dynamic-content'
roots_yaml      = require 'roots-yaml'
records         = require 'roots-records'
shell           = require 'shelljs'

module.exports =
  ignores: [
    'readme.md'
    'ship.*conf'
    '**/layout.*'
    '**/_*'
    '.gitignore'
    'scripts/**'
    'bower.json'
    'app.sublime-project'
    'spec/**'
    # 'data/**' 
  ]

  extensions: [
    roots_yaml()
    dynamic()
    records git: file: 'public/posts-git.json'
    js_pipeline
      files: [
        'bower_components/es6-promise/promise.min.js'
        'bower_components/fontfaceobserver/fontfaceobserver.js'
        'bower_components/isotope/dist/isotope.pkgd.min.js'
        'bower_components/lazysizes/lazysizes.min.js'
        # simple no deps
        'assets/js/app.coffee'
        'assets/js/fonts.coffee'
        'assets/js/nav.coffee'
        'assets/js/share.coffee'
        # classes
        'assets/js/grid.coffee'
        'assets/js/search.coffee'
        # view controllers
        'assets/js/feed.coffee'
      ]
      out:    'js/app.js'
      minify: true
      hash:   true
    css_pipeline
      files: [
        'bower_components/reflex/css/reflex.css'
        'assets/css/*.styl'
      ]
      out:    'css/app.css'
      minify: false # minify is not working right now for some reason with roots
      hash:   true
  ]

  stylus:
    use: [
      axis()
      rupture()
      autoprefixer()
    ]

  'coffee-script':
    bare: true

  locals:
    dev:  false
    _:    require 'lodash'
    helpers:
      getAuthor:      require './scripts/get-author'
      getCategories:  require './scripts/get-categories'
      getMergedPosts: require './scripts/get-merged-posts'
      getPostGitData: require './scripts/get-post-git-data'

  before: ->
    shell.exec 'npm run posts-git-log'
    return true
