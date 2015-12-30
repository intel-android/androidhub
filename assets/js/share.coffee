App.Share = (->

  els           = document.querySelectorAll '.share'
  share         = 
    url:        'http://androidhub.intel.com'
    tags:       'AndroidDevs'
    twitter:    'The Android Developer Hub, by developers, for developers, find tips, tuts, and tricks here.'
    facebook:   'The Android Developer Hub, a community where developers can talk to, share with, and learn from other like-minded developers, whether you’re getting ready to develop your first app or an experienced dev with specific questions about the Android development process. Find tips, tuts, and tricks here.'
    googleplus: 'The Android Developer Hub, a community where developers can talk to, share with, and learn from other like-minded developers, whether you’re getting ready to develop your first app or an experienced dev with specific questions about the Android development process. Find tips, tuts, and tricks here.'

  dialogTop = ->
    window.innerHeight / 2 - 225

  dialogLeft = ->
    window.innerWidth / 2

  grabUrl = ->
    if location.href.indexOf('posts/') >= 0 then return location.href else return share.url

  shareToTwitter = ->
    attribute = if document.querySelector 'main.post' then document.getElementsByTagName('meta')['twitter:creator'].content else ''
    attribute = attribute.substr 1, attribute.length
    console.log attribute
    window.open "http://twitter.com/share?url=#{grabUrl()}&text=#{share.twitter}&hashtags=#{share.tags}&url=#{grabUrl()}&via=#{attribute}", "twitterwindow", "height=450, width=550, top=#{dialogTop()}, left=#{dialogLeft()}, toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"

  shareToFacebook = ->
    window.open "https://facebook.com/sharer/sharer.php?u=#{escape(grabUrl())}", "facebookwindow", "height=450, width=550, top=#{dialogTop()}, left=#{dialogLeft()}, toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"

  shareToGoogle = ->
    window.open "https://plus.google.com/share?url=#{escape(grabUrl())}", "googlepluswindow", "height=600, width=600, toolbar=0, location=0, menubar=0, directories=0, scrollbars=yes"

  [].forEach.call els, (el) ->
    el.addEventListener 'click', (e) ->
      e.preventDefault()
      target = e.currentTarget.getAttribute('share-target')

      switch target
        when 'twitter' then shareToTwitter()
        when 'facebook' then shareToFacebook()
        when 'google' then shareToGoogle()
      
      if ga then ga 'send', 'event', 'button', 'click', target

)()