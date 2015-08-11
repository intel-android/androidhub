class Search
  constructor: ->
    @listen()

  listen: ->
    document
      .querySelector '#search'
      .addEventListener 'change', (e) ->
        console.log e
        FeedGrid.filter '.' + e.target.value

new Search()