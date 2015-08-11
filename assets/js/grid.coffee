class App.Grid
  constructor: (options) ->
    # todo: restore filter state if hash is in the url
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

  setState: (filter) ->
    if filter == 'all' then filter = ''
    location.hash = filter

  listen: ->
    # filter click event
    document
      .querySelector '.filters'
      .addEventListener 'click', (e) =>
        return unless e.target.nodeName == 'LI'
        
        filter = e.target.textContent.toLowerCase()
        @setState filter

        if filter == 'all'
          filter = '*'
        else
          filter = '.' + filter
        
        @filter filter
        