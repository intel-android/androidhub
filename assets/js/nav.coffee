paths = location.pathname.split("/")
page = paths[1]
document
  .querySelector "nav a[href^='/#{page}']"
  .classList.add 'active'