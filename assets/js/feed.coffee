return unless document.getElementById 'feed-grid'

feedgrid = new Isotope '#feed-grid',
  itemSelector: '.feed-item'
  layoutMode: 'fitRows'

# todo: restore filter state if hash is in the url

document
  .querySelector('.filters')
  .addEventListener('click', (e) ->
    # add hash state
    feedgrid.arrange filter: ".#{e.target.textContent}"
  )