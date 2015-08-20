class App.Search
  constructor: (FeedGrid) ->
    @Grid = FeedGrid
    @gridNode = document.querySelector('#feed-grid')
    @listen()
    @loadPostsJSON (posts) => @posts = posts.posts

  listen: ->
    document
      .querySelector '#search'
      .addEventListener 'change', (e) =>
        query = e.target.value.toLowerCase()
        results = []

        # query posts object
        for key, author of @posts when key isnt 'items'
          for post in author.items when post.title.toLowerCase().indexOf(query) > -1 | post.content.indexOf(query) > -1
            results.push post.title
        
        # filter grid items by matching titles
        # @Grid.setState query
        @Grid.filter (el) ->
          title = el.querySelector('.post-title').innerText
          results.indexOf(title) > -1

        # show empty results message
        if !results.length
          @gridNode.setAttribute 'data-empty', true
        else 
          @gridNode.removeAttribute 'data-empty'

  loadPostsJSON: (cb) ->
    xobj = new XMLHttpRequest()
    xobj.overrideMimeType "application/json"
    xobj.open 'GET', 'content.json', true
    xobj.onreadystatechange = () ->
      if xobj.readyState == 4 and xobj.status == 200
        cb JSON.parse(xobj.responseText)
    xobj.send null