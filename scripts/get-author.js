module.exports = function(post, data) {
  if (!post) return 'Missing post object parameter'

  var author_handle, author;

  if (post._categories && post._categories.length)
    author_handle = post._categories[1] ? post._categories[1] : 'admin'
  else
    // sometimes post._categories isnt present, we should fallback by extracting it from the url
    author_handle = post._url && post._url.split('/')[2]
  
  author = data.authors[author_handle]
  author['image'] = author.twitter ? 'https://twitter.com/'+ author.twitter +'/profile_image?size=original' : 'http://placehold.it/200x200?text=' + author.displayname

  return author
}