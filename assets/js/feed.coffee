return
return unless document.getElementById 'feed-grid'

feedgrid = new Isotope '#feed-grid',
  itemSelector: '.feed-item'
  layoutMode: 'fitRows'

# todo: restore filter state if hash is in the url

document
  .querySelector '.filters'
  .addEventListener 'click', (e) ->
    filter = '.' + e.target.textContent
    filter = '*' if filter == '.All'
    console.log filter
    # add hash state
    feedgrid.arrange filter: filter
