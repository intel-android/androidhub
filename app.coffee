axis          = require 'axis'
rupture       = require 'rupture'
autoprefixer  = require 'autoprefixer-stylus'
js_pipeline   = require 'js-pipeline'
css_pipeline  = require 'css-pipeline'
dynamic       = require 'dynamic-content'
roots_yaml    = require 'roots-yaml'
records       = require 'roots-records'
shell         = require 'shelljs'
copyLibrary   = require './scripts/copy-library.js'

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
    'tmp'
    'jasmine-runner.js'
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
        'assets/js/share.coffee'
        'assets/js/disqus.coffee'
        'assets/js/natural-language-form.coffee'
        # classes
        'assets/js/grid.coffee'
        'assets/js/search.coffee'
        # view controllers
        'assets/js/feed.coffee'
        'assets/js/commit.coffee'
      ]
    css_pipeline
      files: [
        'bower_components/reflex-grid/css/reflex.css'
        'bower_components/sweetalert/dist/sweetalert.css'
        'assets/css/master.styl'
      ]
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
    bare: true

  jade:
    pretty: true

  locals:
    dev:    true
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
      getHeroImage:     require './scripts/get-hero-image'

  before: ->
    shell.exec 'npm run posts-git-log'

    copyLibrary();
    return true;

  debug: true
