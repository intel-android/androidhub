require('shelljs/global');

var glob          = require('glob');
var path          = require('path');

module.exports = function() {
  mkdir('-p', path.normalize(path.join('public', 'library')));

  var authors = glob.sync(path.normalize(path.join("posts", "*")));
  for (var i = 0; i < authors.length; i++) {
    var author_path = authors[i];
    var author = author_path.split(path.sep)[1];
    mkdir('-p', path.normalize(path.join('public', 'library', author)));
    library = glob.sync(path.normalize(path.join("posts", author, 'library', '*')));
    for (var j = 0; j < library.length; j++) {
      var asset = library[j];
      var filename = asset.split(path.sep).pop();
      cp(asset, path.normalize(path.join('public', 'library', author, filename)));
    }
  }
  return true;
};
