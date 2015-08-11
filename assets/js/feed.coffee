class Feed
  constructor: ->
    # dont do anything unless we're on the feed grid page
    return unless document.getElementById 'feed-grid'

    # init grid from Grid class
    @FeedGrid = new Grid
      id:   'feed-grid'
      item: '.feed-item'

    # init search class and pass grid class
    new Search(@FeedGrid)

# init self
new Feed()