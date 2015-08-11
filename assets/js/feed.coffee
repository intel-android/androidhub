class App.Feed
  constructor: ->
    # dont do anything unless we're on the feed grid page
    return unless document.getElementById 'feed-grid'

    # init grid from Grid class
    @FeedGrid = new App.Grid
      id:   'feed-grid'
      item: '.feed-item'

    # init search class and pass grid class
    new App.Search(@FeedGrid)

# init self
App.Feed()