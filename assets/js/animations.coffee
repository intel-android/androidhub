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

  if els.socialNavIcons
    Velocity els.socialNavIcons, 'transition.expandIn',
      drag:     true
      stagger:  200

  if els.homeHero
    els.homeHero.addEventListener 'load', ->
      Velocity els.homeHeader, 'transition.slideUpIn',
        drag:     true
        stagger:  250
        display:  ''
        complete: ->
          Velocity els.heroNameplate, 'transition.slideLeftIn',
            drag:     true
            stagger:  250
            display:  ''

  if els.homeFeedItems
    for el in els.homeFeedItems
      el.querySelector('img').addEventListener 'load', (e) ->
        Velocity e.target.parentNode.parentNode, 'transition.slideUpIn', display: ''

  # if els.hubTitle
  #   Velocity els.hubTitle, 'callout.pulse',
  #     delay:    3000
  #     display:  ''

  if els.sectionTitle
    Velocity els.sectionTitle, 'transition.slideDownIn'

  if els.articleAvatar && els.nameplate
    els.articleAvatar.addEventListener 'load', ->
      # remove class so hover animation is proper
      els.articleAvatar.classList.remove 'lazyanimate'
      # animate in avatar name and social
      Velocity els.nameplate, 'transition.slideLeftIn',
        drag:     true
        stagger:  250
        display:  ''
        delay:    500

  els.intelLogo.addEventListener 'load', ->
    Velocity els.commitButton, 'callout.tada', delay: 1500
