class App.Grid
  constructor: (options) ->
    @initGrid(options)
    @restoreState()
    @listen()

  filter: (q) ->
    @feedgrid.arrange filter: q

  initGrid: (options) ->
    @feedgrid = new Isotope '#' + options.id,
      itemSelector: options.item
      layoutMode:   'fitRows'

  restoreState: ->
    hash = location.hash
    if hash then @filter hash.replace('#', '.')
    if !@activeItem
      if hash == '' then hash = '#all'
      @setActiveItem document.querySelector(hash)


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
    document
      .querySelector '.filters'
      .addEventListener 'click', (e) =>
        return unless e.target.nodeName == 'LI'

        filter = e.target.textContent.toLowerCase()
        @setActiveItem e.target
        @setState filter

        if filter == 'all'
          filter = '*'
        else
          filter = '.' + filter
        
        @filter filter
        