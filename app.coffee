axis          = require 'axis'
rupture       = require 'rupture'
autoprefixer  = require 'autoprefixer-stylus'
js_pipeline   = require 'js-pipeline'
css_pipeline  = require 'css-pipeline'
dynamic       = require 'dynamic-content'

module.exports =
  ignores: [
    'readme.md'
    '**/layout.*'
    '**/_*'
    '.gitignore'
    'ship.*conf'
  ]

  extensions: [
    js_pipeline(files: [
      'assets/js/*.coffee'
      'bower_components/isotope/dist/isotope.pkgd.min.js'
    ])
    css_pipeline(files: [
      'assets/css/*.styl'
      'bower_components/reflex/css/reflex.css'
    ])
    dynamic(write: 'content.json')
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
    base: '/'
    _: require 'lodash'

  debug: true
