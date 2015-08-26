class App.Grid
  constructor: (options) ->
    @filters = document.getElementById 'feed-filter'
    @initGrid(options)
    @restoreState()
    @listen()

  filter: (q) ->
    @feedgrid.arrange filter: q

  initGrid: (options) ->
    @feedgrid = new Isotope '#' + options.id,
      itemSelector: options.item
      layoutMode:   'fitRows'
    # set min height on the grid container for tall browsers
    footer                = document.querySelector 'footer'
    grid                  = document.querySelector '#feed-grid'
    docHeight             = footer.offsetTop + footer.offsetHeight
    winHeight             = window.innerHeight
    grid.style.minHeight  = grid.offsetHeight + (winHeight - docHeight) + 10 + 'px'

  restoreState: ->
    hash = location.hash.replace '#', '.'
    
    if hash
      @filter hash
      if hash == '' then hash = 'all' else hash = hash.replace '.', ''
      @setActiveItem hash

  setState: (filter) ->
    if filter == 'all' then filter = ''
    location.hash = filter

  setActiveItem: (val) ->
    @filters.value = val

  listen: ->
    # selectbox change event
    @filters.addEventListener 'change', (e) =>
      filter = e.target.value
      @setState filter

      # convert select value to filter that isotope wants
      filter = if filter == 'all' then '*' else '.' + filter
      @filter filter
        