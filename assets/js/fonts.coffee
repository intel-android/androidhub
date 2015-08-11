class App.Fonts
  # return unless document.documentElement.className.indexOf('fonts-loaded') > -1

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
        console.info 'font available'
        document.documentElement.className += ' fonts-loaded'
      () ->
        console.error 'font NOT available'
    )
