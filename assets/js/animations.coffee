class Animations

  els =
    socialNavIcons: document.querySelectorAll 'nav .auto-width-xs > a' 
    hubTitle:       document.querySelector '.text-overlay > h5'
    homeHeader:     document.querySelectorAll '.heroimage, .hero-title, .author-nameplate'
    homeHero:       document.querySelector '.heroimage'

  if els.socialNavIcons
    Velocity els.socialNavIcons, 'transition.expandIn',
      drag:     true
      stagger:  200

  if els.homeHero
    els.homeHero.addEventListener 'load', ->
      Velocity els.homeHeader, 'transition.slideLeftIn',
        drag:     true
        stagger:  250
        display:  ''

  if els.hubTitle
    Velocity els.hubTitle, 'transition.slideUpIn',
      delay:    1000
      display:  ''
