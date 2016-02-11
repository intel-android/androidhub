var shell         = require('shelljs');
var glob          = require('glob');

module.exports = function() {
  console.log('copying library items...')
  shell.exec('mkdir -p public/library');
  var authors = glob.sync("posts/*/");
  for (var i = 0; i < authors.length; i++) {
    var path = authors[i];
    var author = path.split('/')[1];
    shell.exec("mkdir -p public/library/" + author);
    library = glob.sync("posts/" + author + '/library/*');
    for (var j = 0; j < library.length; j++) {
      var asset = library[j];
      var filename = asset.split('/').pop();
      shell.exec("cp " + asset + " public/library/" + author + "/" + filename);
    }
  }
  return true;
};
