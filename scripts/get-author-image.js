module.exports = function(author) {
  return author.twitter ? 'https://twitter.com/'+ author.twitter +'/profile_image?size=original' : 'http://placehold.it/200x200?text=' + author.displayname
}