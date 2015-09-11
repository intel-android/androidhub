var _ = require('lodash')

module.exports = function(authors) {
  return _.sortBy(authors, function(author){
    var nameArray = author.displayname.split(' ') // split name into pieces
    return nameArray[nameArray.length - 1] // get last name
  })
}