module.exports = function(post, records) {
  if (!post) return 'Missing post object parameter'

  var url = post._url.substr(1, post._url.length - 6) + '.jade'
  var git = records.git[url] ? records.git[url] : records.git['posts/argyleink/first.jade']

  return git
}