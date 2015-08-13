var _ = require('lodash')

module.exports = function(site) {
  if (!site) return 'Missing post object parameter'

  var allCats = _.map(site.posts.all(), function(post){ return post.categories })
  var flatCats = _.flatten(allCats)
  var uniqCats = _.uniq(flatCats, function(cat){ return cat })

  return uniqCats

  // return 
  //   _.chain(site.posts.all())
  //   .map(function(post){ 
  //     return post.categories 
  //   })
  //   .flatten()
  //   .uniq(function(cat){ return cat })
}