App.Track = (->

  els = 
    homeHero:         document.querySelector '.hero > section > a'
    homeRecent:       document.querySelectorAll '.recent .feed-item > a'
    homeTestimonial:  document.querySelector '.testimonial a'
    footerCommit:     document.querySelector 'footer .btn.blue'
    relatedPost:      document.querySelector '.related-post a'
    feedItem:         document.querySelectorAll '#feed-grid > .feed-item > a'
    feedFilter:       document.querySelector '#feed-filter'
    formSubmit:       document.querySelector '.nl-submit-wrap'
  
  if els.homeHero then els.homeHero.addEventListener 'click', -> track 'home-hero'
  if els.homeTestimonial then els.homeTestimonial.addEventListener 'click', -> track 'home-testimonial'
  if els.footerCommit then els.footerCommit.addEventListener 'click', -> track 'footer-commit'
  if els.relatedPost then els.relatedPost.addEventListener 'click', -> track 'related-post'
  if els.formSubmit then els.formSubmit.addEventListener 'click', -> track 'form-submit'
  if els.feedFilter then els.feedFilter.addEventListener 'change', (e) -> 
    if window.ga then ga 'send', 'event', 'input', 'filter', e.target.value

  if els.homeRecent
    for el in els.homeRecent
      el.addEventListener 'click', -> track 'home-recent'

  if els.feedItem
    for el in els.feedItem
      el.addEventListener 'click', -> track 'feed-item'

  track = (target) ->  
    console.log 'tracking ' + target  
    if window.ga then ga 'send', 'event', 'button', 'click', target

)()