var _ = require('lodash')

module.exports = function(post, posts) {
  if (!post) return 'Missing post object parameter'

  // get all posts that share categories in the post
  var catMatches = _.filter(posts, function(p){
    return _.intersection(p.categories, post.categories).length
  })

  // remove current post and template from that collection
  catMatches = _.filter(catMatches, function(p){
    return p._url !== post._url && p._url !== '/posts/template.html'
  })

  // limit to 2 results
  return _.slice(catMatches, 0, 2)
}