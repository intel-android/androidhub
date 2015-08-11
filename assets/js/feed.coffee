class Feed
  constructor: ->
    return unless document.getElementById 'feed-grid'
    # todo: restore filter state if hash is in the url
    @initGrid()
    @listen()

  filter: (q) ->
    @feedgrid.arrange filter: q

  initGrid: ->
    @feedgrid = new Isotope '#feed-grid',
      itemSelector: '.feed-item'
      layoutMode: 'fitRows'

  listen: ->
    document
      .querySelector '.filters'
      .addEventListener 'click', (e) =>
        return unless e.target.nodeName == 'LI'
        filter = '.' + e.target.textContent.toLowerCase()
        filter = '*' if filter == '.all'
        # set hash state
        @.filter filter

FeedGrid = new Feed()