module.exports = function(post) {
  author_handle = post._url && post._url.split('/')[2];

  return post.heroimage ? '/library/' + author_handle + '/' + post.heroimage : '/img/placeholder.svg';
};
