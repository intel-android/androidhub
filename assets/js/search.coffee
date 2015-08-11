class Search
  constructor: (FeedGrid) ->
    @Grid = FeedGrid
    @listen()

  listen: ->
    document
      .querySelector '#search'
      .addEventListener 'change', (e) =>
        console.log e
        @Grid.filter '.' + e.target.value
