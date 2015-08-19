var _ = require('lodash')

module.exports = function(site, records) {
  if (!site) return 'Missing site object parameter'

  // remove template post
  var filteredPosts = _.filter(site.posts.all(), function(post){
    return !post._ignore
  })

  // rename all post urls to jade names, to match the git keys
  var renamedPostUrls = _.forEach(filteredPosts, function(post){ 
    post.git_url = post._url.substr(1, post._url.length - 6) + '.jade' 
  })

  // merge posts and git objects based on new key created
  var mergedObjects = _.forEach(renamedPostUrls, function(post){ 
    post.git = records.git[post.git_url] ? records.git[post.git_url] : records.git['posts/argyleink/first.jade'] 
  })

  return mergedObjects
}