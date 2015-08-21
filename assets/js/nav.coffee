App.Nav = (->
  paths     = location.pathname.split("/")
  page      = paths[1]
  curNode   = document.querySelector "nav a[href^='/#{page}']"

  if curNode then curNode.className = 'active'
)()