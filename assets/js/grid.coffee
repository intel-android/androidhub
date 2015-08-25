class App.Grid
  constructor: (options) ->
    @filters = document.querySelector '.filters'
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
    hash        = location.hash
    hashClass   = hash.replace('#', '.')
    
    if hash then @filter 
    if !@activeItem
      if hash == '' then hash = '#all'
      @setActiveItem @filters.querySelector hashClass


  setState: (filter) ->
    if filter == 'all' then filter = ''
    location.hash = filter

  setActiveItem: (el) ->
    return unless el
    if @activeItem then @activeItem.className = ''
    @activeItem = el
    @activeItem.className = 'active'

  listen: ->
    # filter click event
    @filters.addEventListener 'click', (e) =>
      return unless e.target.nodeName == 'LI'

      filter = e.target.textContent.toLowerCase()
      @setActiveItem e.target
      @setState filter

      if filter == 'all'
        filter = '*'
      else
        filter = '.' + filter
      
      @filter filter
        