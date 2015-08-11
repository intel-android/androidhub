class Grid
  constructor: (options) ->
    # todo: restore filter state if hash is in the url
    @initGrid(options)
    @listen()

  filter: (q) ->
    @feedgrid.arrange filter: q

  initGrid: (options) ->
    @feedgrid = new Isotope '#' + options.id,
      itemSelector: options.item
      layoutMode:   'fitRows'

  listen: ->
    document
      .querySelector '.filters'
      .addEventListener 'click', (e) =>
        return unless e.target.nodeName == 'LI'
        filter = '.' + e.target.textContent.toLowerCase()
        filter = '*' if filter == '.all'
        # set hash state
        @.filter filter
        