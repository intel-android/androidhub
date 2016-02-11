var shell   = require('shelljs')
var glob    = require('glob')

module.exports = function() {
  console.log('making thumbnails of library images...')

  // grab images that were copied over, ignoring any already created thumbs
  var images = glob.sync("public/library/**/*.{jpg,jpeg,png}", {
    ignore: '**/*-thumb.*'
  })

  images.forEach(function(image, i){
    var pos = image.indexOf('.')
    var thumb = [image.slice(0, pos), '-thumb', image.slice(pos)].join('')
    shell.exec('convert '+ image +' -resize 300 ' + thumb)
  })

  return true
}