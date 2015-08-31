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
    'authors_readme.md'
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
    dynamic write: 'content.json'
    records git: file: 'public/posts-git.json'
    js_pipeline
      files: [
        'bower_components/fastclick/lib/fastclick.js'
        'bower_components/es6-promise/promise.min.js'
        'bower_components/fontfaceobserver/fontfaceobserver.js'
        'bower_components/isotope/dist/isotope.pkgd.min.js'
        'bower_components/lazysizes/lazysizes.min.js'
        'bower_components/sweetalert/dist/sweetalert-dev.js'
        # simple no deps
        'assets/js/app.coffee'
        'assets/js/fonts.coffee'
        'assets/js/nav.coffee'
        'assets/js/share.coffee'
        'assets/js/natural-language-form.coffee'
        # classes
        'assets/js/grid.coffee'
        'assets/js/search.coffee'
        # view controllers
        'assets/js/feed.coffee'
        'assets/js/commit.coffee'
      ]
      out:    'js/app.js'
      minify: true
      hash:   false
    css_pipeline
      files: [
        'bower_components/reflex/css/reflex.css'
        'bower_components/sweetalert/dist/sweetalert.css'
        'assets/css/*.styl'
      ]
      out:    'css/app.css'
      minify: false # minify is not working right now for some reason with roots
      hash:   false
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
    dev:    false
    _:      require 'lodash'
    moment: require 'moment'
    helpers:
      getAuthor:        require './scripts/get-author'
      getAuthorImage:   require './scripts/get-author-image'
      getCategories:    require './scripts/get-categories'
      getMergedPosts:   require './scripts/get-merged-posts'
      getPostGitData:   require './scripts/get-post-git-data'
      getFeatured:      require './scripts/get-featured'
      getRelatedPosts:  require './scripts/get-related-posts'
      socialLink:       require './scripts/social-link'

  before: ->
    shell.exec 'npm run posts-git-log'
    # shell.exec 'npm test'
    return true

  after: ->
    # shell.exec 'node_modules/purify-css/bin/purifycss public/css/app.css public/index.html public/feed.html public/about.html public/authors.html public/commit.html public/posts/template.html public/js/app.js --out public/css/app.css'
    shell.exec 'node_modules/csso/bin/csso public/css/app.css public/css/app.css'
