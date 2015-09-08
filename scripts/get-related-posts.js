var _ = require('lodash')

module.exports = function(post, posts) {
  if (!post) return 'Missing post object parameter'

  var filtered, catMatches, results

  // remove current post and template from that collection
  filtered = _.filter(posts, function(p){
    return p._url !== post._url && p._url !== '/posts/template.html'
  })

  // get all posts that share categories in the post
  catMatches = _.filter(filtered, function(p){
    return _.intersection(p.categories, post.categories).length
  })

  // limit to 2 results
  results = _.slice(catMatches, 0, 2)

  // if we have results, then send them over, otherwise send 2 other posts
  return results.length > 0 ? results : _.slice(filtered, 0, 2)
}