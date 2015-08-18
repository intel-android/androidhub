App.Fonts = (->
  # dont load the fonts if we've already loaded them on the first page visit
  # see includes/_font-strategy.jade
  return if !!localStorage['fonts-loaded']

  reg     = new FontFaceObserver 'clearsans-regular', weight: 300
  light   = new FontFaceObserver 'clearsans-light', weight: 100
  bold    = new FontFaceObserver 'clearsans-bold', weight: 600

  window.Promise
    .all([
      reg.check()
      light.check()
      bold.check()
    ])
    .then(
      () ->
        document.documentElement.className += 'fonts-loaded'
        localStorage['fonts-loaded'] = true
      () ->
        console.error 'error loading font'
    )
)()