App.Commit = (->
  # dont do anything unless we're on the feed grid page
  @form = document.getElementById 'nl-form'
  return unless @form
  new NLForm @form

  @requiredFormElements =
    name:       document.getElementById 'author-name'
    email:      document.getElementById 'author-email'
    expertise:  document.getElementById 'author-expertise'
    site:       document.getElementById 'author-site'

  document
    .querySelector 'button[type=submit]'
    .addEventListener 'click', (e) =>
      e.preventDefault()

      # verify all fields are filled out
      for k,v of @requiredFormElements
        complete = checkEl(v)

      if complete then done() else notDone()

  # @form.addEventListener 'change', (e) =>
  #   checkEl(e.target.parentNode.parentNode.parentNode.nextSibling)

  checkEl = (el) ->
    if el.value && el.checkValidity()
      complete = true
      el.previousSibling.classList.remove('error')
      # el.previousSibling.classList.add('complete')
    else
      complete = false
      # el.previousSibling.classList.remove('complete')
      el.previousSibling.classList.add('error')

    return complete

  notDone = () ->
    swal
      title:  'Doh!'
      text:   'You missed a spot.'
      type:   'error'

  done = () ->
    data =
      name:       @requiredFormElements.name.value
      email:      @requiredFormElements.email.value
      expertise:  @requiredFormElements.expertise.value
      site:       @requiredFormElements.site.value
      message:    document.getElementById('author-message').value

    console.log data

    xobj = new XMLHttpRequest()
    xobj.overrideMimeType "application/json"
    xobj.open 'POST', 'commit.php'
    xobj.onreadystatechange = () ->
      if xobj.readyState == 4 and xobj.status == 200
        json = JSON.parse(xobj.responseText)
        swal
          title:  'Nice!'
          text:   json.message
          type:   'success'
    xobj.send JSON.stringify data



)()
