App.Share = (->

  twitter       = document.getElementById('tweet')
  facebook      = document.getElementById('post')
  googleplus    = document.getElementById('plus')
  shareUrl      = 'http://androidhub.intel.com'
  share         = 
    twitter:    'The Android Developer Hub, by developers, for developers, find tips, tuts, and tricks here.'
    facebook:   'The Android Developer Hub, a community where developers can talk to, share with, and learn from other like-minded developers, whether you’re getting ready to develop your first app or an experienced dev with specific questions about the Android development process. Find tips, tuts, and tricks here.'
    googleplus: 'The Android Developer Hub, a community where developers can talk to, share with, and learn from other like-minded developers, whether you’re getting ready to develop your first app or an experienced dev with specific questions about the Android development process. Find tips, tuts, and tricks here.'
    tags:       'intelandroidhub'

  dialogTop = ->
    window.innerHeight / 2 - 225

  dialogLeft = ->
    window.innerWidth / 2

  twitter.addEventListener 'click', (e) ->
    e.preventDefault()
    window.open "http://twitter.com/share?url=#{shareUrl}&text=#{share.twitter}&hashtags=#{share.tags}&url=#{shareUrl}&', 'twitterwindow', 'height=450, width=550, top=#{dialogTop()}, left=#{dialogLeft()}, toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"
    # ga 'send', 'event', 'button', 'click', 'twitter'

  facebook.addEventListener 'click', (e) ->
    e.preventDefault()
    window.open "https://facebook.com/sharer/sharer.php?u=#{escape(shareUrl)}, 'facebookwindow', 'height=450, width=550, top=#{dialogTop()}, left=#{dialogLeft()}, toolbar=0, location=0, menubar=0, directories=0, scrollbars=0"
    # ga 'send', 'event', 'button', 'click', 'facebook'

  googleplus.addEventListener 'click', (e) ->
    e.preventDefault()
    window.open "https://plus.google.com/share?url=#{escape(shareUrl)}, 'googlepluswindow', 'height=600, width=600, toolbar=0, location=0, menubar=0, directories=0, scrollbars=yes"
)()