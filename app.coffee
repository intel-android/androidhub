axis          = require 'axis'
rupture       = require 'rupture'
autoprefixer  = require 'autoprefixer-stylus'
js_pipeline   = require 'js-pipeline'
css_pipeline  = require 'css-pipeline'
dynamic       = require 'dynamic-content'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee')
    css_pipeline(files: 'assets/css/*.styl')
    dynamic(write: 'content.json')
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  locals:
    dev: true
    _: require 'lodash'

  debug: true
