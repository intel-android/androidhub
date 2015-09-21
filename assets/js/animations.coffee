class Animations

  els =
    socialNavIcons: document.querySelectorAll 'nav .auto-width-xs > a' 
    hubTitle:       document.querySelector '.text-overlay > h5'
    homeHeader:     document.querySelectorAll '.heroimage, .hero-title, .author-nameplate'
    heroNameplate:  document.querySelectorAll '.author-nameplate > h4, .author-nameplate > a'
    homeHero:       document.querySelector '.heroimage'
    sectionTitle:   document.querySelector '.section-title h3'
    homeFeedItems:  document.querySelectorAll '.recent .feed-item'
    intelLogo:      document.querySelector '.intel-logo'
    commitButton:   document.querySelector '.site-map .btn.blue'
    articleAvatar:  document.querySelector '.header-nameplate .avatar'
    nameplate:      document.querySelectorAll '.meta > *'

  # top nav social svg icons
  if els.socialNavIcons
    Velocity els.socialNavIcons, 'transition.expandIn',
      drag:     true
      stagger:  200

  # home page hero image
  animateHomeHero = ->
    Velocity els.homeHeader, 'transition.slideUpIn',
      drag:     true
      stagger:  250
      display:  ''
      complete: ->
        Velocity els.heroNameplate, 'transition.slideLeftIn',
          drag:     true
          stagger:  250
          display:  ''

  if els.homeHero
    if els.homeHero.complete then animateHomeHero()
    else els.homeHero.onload = animateHomeHero

  # home page recent posts items
  if els.homeFeedItems
    for el in els.homeFeedItems
      el.querySelector('img').addEventListener 'load', (e) ->
        Velocity e.target.parentNode.parentNode, 'transition.slideUpIn', display: ''

  # if els.hubTitle
  #   Velocity els.hubTitle, 'callout.pulse',
  #     delay:    3000
  #     display:  ''

  # each page title that's just under the nav
  if els.sectionTitle
    Velocity els.sectionTitle, 'transition.slideDownIn'

  # article hero image
  animateArticleHero = ->
    # remove class so hover animation is proper
    els.articleAvatar.classList.remove 'lazyanimate'
    # animate in avatar name and social
    Velocity els.nameplate, 'transition.slideLeftIn',
      drag:     true
      stagger:  250
      display:  ''
      delay:    500

  if els.articleAvatar && els.nameplate
    if els.articleAvatar.complete then animateArticleHero()
    else els.articleAvatar.onload = animateArticleHero

  # footer intel logo
  els.intelLogo.addEventListener 'load', ->
    Velocity els.commitButton, 'callout.tada', delay: 1500
