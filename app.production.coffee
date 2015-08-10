axis            = require 'axis'
rupture         = require 'rupture'
autoprefixer    = require 'autoprefixer-stylus'
js_pipeline     = require 'js-pipeline'
css_pipeline    = require 'css-pipeline'
dynamic         = require 'dynamic-content'
roots_yaml      = require 'roots-yaml'

module.exports =
  ignores: [
    'readme.md'
    'ship.*conf'
    '**/layout.*'
    '**/_*'
    '.gitignore'
    'bower.json'
    'app.sublime-project'
    'spec/**'
    # 'data/**' 
  ]

  extensions: [
    roots_yaml()
    dynamic()
    js_pipeline
      files: [
        'bower_components/isotope/dist/isotope.pkgd.min.js'
        'assets/js/*.coffee'
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
