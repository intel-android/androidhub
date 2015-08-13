module.exports = function(post, data) {
  if (!post) return 'Missing post object parameter'

  var author_handle   = post._categories[1] ? post._categories[1] : 'admin'
  var author          = data.authors[author_handle]
  author['image']     = author.twitter ? 'https://twitter.com/'+ author.twitter +'/profile_image?size=original' : 'http://placehold.it/200x200?text=' + author.displayname

  return author
}