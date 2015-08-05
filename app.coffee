axis          = require 'axis'
rupture       = require 'rupture'
autoprefixer  = require 'autoprefixer-stylus'
js_pipeline   = require 'js-pipeline'
css_pipeline  = require 'css-pipeline'
dynamic       = require 'dynamic-content'
roots_yaml    = require 'roots-yaml'

module.exports =
  ignores: [
    'readme.md'
    '**/layout.*'
    '**/_*'
    '.gitignore'
    'ship.*conf'
  ]

  extensions: [
    roots_yaml()
    dynamic(write: 'content.json')
    js_pipeline(files: [
      'bower_components/isotope/dist/isotope.pkgd.min.js'
      'assets/js/*.coffee'
    ])
    css_pipeline(files: [
      'bower_components/reflex/css/reflex.css'
      'assets/css/*.styl'
    ])
  ]

  stylus:
    use: [
      axis()
      rupture()
      autoprefixer()
    ]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  locals:
    dev: true
    _: require 'lodash'

  debug: true
