var _ = require('lodash')

module.exports = function(site) {
  if (!site) return 'Missing site object parameter'
  return _.filter(site.posts.all(), 'featured')
}