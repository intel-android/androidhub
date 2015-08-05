axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
dynamic         = require 'dynamic-content'
roots_yaml      = require 'roots-yaml'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    roots_yaml()
    dynamic()
    js_pipeline(files: 'assets/js/*.coffee', out: 'js/app.js', minify: false, hash: true),
    css_pipeline(files: 'assets/css/*.styl', out: 'css/app.css', minify: false, hash: true),
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]

  locals:
    dev:  false
    _:    require 'lodash'
