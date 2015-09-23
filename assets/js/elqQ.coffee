_elqQ = _elqQ or []
_elqQ.push [
  'elqSetSiteId'
  '334284386'
]
_elqQ.push [ 'elqTrackPageView' ]

do ->
  async_load = ->
    s = document.createElement('script')
    s.type = 'text/javascript'
    s.async = true
    s.src = '//img03.en25.com/i/elqCfg.min.js'
    x = document.getElementsByTagName('script')[0]
    x.parentNode.insertBefore s, x

  if window.addEventListener
    window.addEventListener 'DOMContentLoaded', async_load, false
  else if window.attachEvent
    window.attachEvent 'onload', async_load