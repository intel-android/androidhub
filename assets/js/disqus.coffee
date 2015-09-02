App.Disqus = (->
  @disqus = document.getElementById 'disqus_thread'
  return unless @disqus

  disqus_shortname = 'intel-android-developer-hub'
  do ->
    dsq = document.createElement('script')
    dsq.type = 'text/javascript'
    dsq.async = true
    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js'
    (document.getElementsByTagName('head')[0] or document.getElementsByTagName('body')[0]).appendChild dsq
)()