module.exports = function(author) {
  return author.twitter ? 'https://twitter.com/'+ author.twitter +'/profile_image?size=original' : '/img/placeholder.svg'
}