do (window) ->

  languages = ['en', 'zh-hans', 'pt', 'ru', 'es']
  defaultLanguage = 'en'
  languageSelector = document.getElementById 'language-selector'
  urlParts = []

  _getUrl = ->
    window.location.href

  _urlParts = ->
    urlParts = _getUrl().split '/'

  _getCurrentLanguage = ->
    currentLanguage = urlParts[3]
    if languages.indexOf(currentLanguage) isnt -1
      currentLanguage
    else
      defaultLanguage

  _setCurrentLanguage = ->
    languageSelector.value = _getCurrentLanguage()

  _changeLanguage = (language) ->
    urlParts[3] = language
    window.location.href =  urlParts.join '/'

  _watchSelector = ->
    languageSelector.addEventListener 'change', (ev) ->
      _changeLanguage ev.target.value

  Init = ->
    _urlParts()
    _setCurrentLanguage()
    _watchSelector()

  Init()
