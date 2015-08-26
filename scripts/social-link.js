module.exports = function(social_target, handle) {
  var url;

  switch(social_target) {
    case 'twitter':
      url = 'https://twitter.com/' + handle
      break;
    case 'github':
      url = 'https://github.com/' + handle
      break;
    case 'codepen':
      url = 'https://codepen.io/' + handle
      break;
    default:
      url = '#'
      break;
  }

  return url;
}