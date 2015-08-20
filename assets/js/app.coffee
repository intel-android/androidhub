class App
  ES6Promise.polyfill()

  document.addEventListener 'lazybeforeunveil', (e) ->
    bg = e.target.getAttribute 'data-bg'
    if bg
      e.target.style.backgroundImage = "url(#{bg})"
      e.target.removeAttribute 'data-bg'