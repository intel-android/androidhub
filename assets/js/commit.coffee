App.Commit = (->
  # dont do anything unless we're on the feed grid page
  @form = document.getElementById('nl-form')
  return unless @form

  new NLForm @form
)()