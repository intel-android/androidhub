class TextEffect
  random_num  = document.querySelectorAll '.nbr'
  timer       = 8
  data        = 0
  letters     = "Android tips, tuts and tricks from one developer to another.".split ''

  for num in random_num
    change = Math.round (Math.random() * 100)
    num.setAttribute 'data-change', change

  random = ->
    return Math.round(Math.random() * 9)

  select = ->
    return Math.round(Math.random() * random_num.length+1)

  value = ->
    el = document.querySelector ".nbr:nth-child(#{select()})"
    if not el then return
    el.innerHTML = random()
    el.setAttribute 'data-number', data
    data++

    for num, i in random_num
      if parseInt(num.getAttribute('data-number')) > parseInt(num.getAttribute('data-change'))
        num.innerHTML = letters[i]
        num.className = ''

    if data.length >= random_num.length * 2
      clearInterval it

  it = setInterval value, timer