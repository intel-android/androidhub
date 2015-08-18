do (window) ->

  NLForm = (el) ->
    @el = el
    @overlay = @el.querySelector('.nl-overlay')
    @fields = []
    @fldOpen = -1
    @_init()
    return

  NLField = (form, el, type, idx) ->
    @form = form
    @elOriginal = el
    @pos = idx
    @type = type
    @_create()
    @_initEvents()
    return

  'use strict'
  document = window.document
  if !String::trim

    String::trim = ->
      @replace /^\s+|\s+$/g, ''

  NLForm.prototype =
    _init: ->
      self = this
      Array::slice.call(@el.querySelectorAll('select')).forEach (el, i) ->
        self.fldOpen++
        self.fields.push new NLField(self, el, 'dropdown', self.fldOpen)
        return
      Array::slice.call(@el.querySelectorAll('input:not([type="hidden"])')).forEach (el, i) ->
        self.fldOpen++
        self.fields.push new NLField(self, el, 'input', self.fldOpen)
        return
      @overlay.addEventListener 'click', (ev) ->
        self._closeFlds()
        return
      @overlay.addEventListener 'touchstart', (ev) ->
        self._closeFlds()
        return
      return
    _closeFlds: ->
      if @fldOpen != -1
        @fields[@fldOpen].close()
      return
  NLField.prototype =
    _create: ->
      if @type == 'dropdown'
        @_createDropDown()
      else if @type == 'input'
        @_createInput()
      return
    _createDropDown: ->
      self = this
      @fld = document.createElement('div')
      @fld.className = 'nl-field nl-dd'
      @toggle = document.createElement('a')
      @toggle.innerHTML = @elOriginal.options[@elOriginal.selectedIndex].innerHTML
      @toggle.className = 'nl-field-toggle'
      @optionsList = document.createElement('ul')
      ihtml = ''
      Array::slice.call(@elOriginal.querySelectorAll('option')).forEach (el, i) ->
        ihtml += if self.elOriginal.selectedIndex == i then '<li class="nl-dd-checked">' + el.innerHTML + '</li>' else '<li>' + el.innerHTML + '</li>'
        # selected index value
        if self.elOriginal.selectedIndex == i
          self.selectedIdx = i
        return
      @optionsList.innerHTML = ihtml
      @fld.appendChild @toggle
      @fld.appendChild @optionsList
      @elOriginal.parentNode.insertBefore @fld, @elOriginal
      @elOriginal.style.display = 'none'
      return
    _createInput: ->
      self = this
      @fld = document.createElement('div')
      @fld.className = 'nl-field nl-ti-text'
      @toggle = document.createElement('a')
      @toggle.innerHTML = if @elOriginal.getAttribute('value') then @elOriginal.getAttribute('value') else @elOriginal.getAttribute('placeholder')
      @toggle.className = 'nl-field-toggle'
      @optionsList = document.createElement('ul')
      @getinput = document.createElement('input')
      @getinput.setAttribute 'type', if @elOriginal.getAttribute('type') then @elOriginal.getAttribute('type') else ''
      @getinput.setAttribute 'placeholder', @elOriginal.getAttribute('placeholder')
      @getinput.setAttribute 'value', if @elOriginal.getAttribute('value') then @elOriginal.getAttribute('value') else ''
      @getinputWrapper = document.createElement('li')
      @getinputWrapper.className = 'nl-ti-input'
      @inputsubmit = document.createElement('button')
      @inputsubmit.className = 'nl-field-go'
      @inputsubmit.innerHTML = 'Go'
      @getinputWrapper.appendChild @getinput
      @getinputWrapper.appendChild @inputsubmit
      @example = document.createElement('li')
      @example.className = 'nl-ti-example'
      @example.innerHTML = @elOriginal.getAttribute('data-subline')
      @optionsList.appendChild @getinputWrapper
      @optionsList.appendChild @example
      @fld.appendChild @toggle
      @fld.appendChild @optionsList
      @elOriginal.parentNode.insertBefore @fld, @elOriginal
      @elOriginal.style.display = 'none'
      return
    _initEvents: ->
      self = this
      @toggle.addEventListener 'click', (ev) ->
        ev.preventDefault()
        ev.stopPropagation()
        self._open()
        return
      @toggle.addEventListener 'touchstart', (ev) ->
        ev.preventDefault()
        ev.stopPropagation()
        self._open()
        return
      if @type == 'dropdown'
        opts = Array::slice.call(@optionsList.querySelectorAll('li'))
        opts.forEach (el, i) ->
          el.addEventListener 'click', (ev) ->
            ev.preventDefault()
            self.close el, opts.indexOf(el)
            return
          el.addEventListener 'touchstart', (ev) ->
            ev.preventDefault()
            self.close el, opts.indexOf(el)
            return
          return
      else if @type == 'input'
        @getinput.addEventListener 'keydown', (ev) ->
          if ev.keyCode == 13
            self.close()
          return
        @inputsubmit.addEventListener 'click', (ev) ->
          ev.preventDefault()
          self.close()
          return
        @inputsubmit.addEventListener 'touchstart', (ev) ->
          ev.preventDefault()
          self.close()
          return
      return
    _open: ->
      if @open
        return false
      @open = true
      @form.fldOpen = @pos
      self = this
      @fld.className += ' nl-field-open'
      return
    close: (opt, idx) ->
      if !@open
        return false
      @open = false
      @form.fldOpen = -1
      @fld.className = @fld.className.replace(/\b nl-field-open\b/, '')
      if @type == 'dropdown'
        if opt
          # remove class nl-dd-checked from previous option
          selectedopt = @optionsList.children[@selectedIdx]
          selectedopt.className = ''
          opt.className = 'nl-dd-checked'
          @toggle.innerHTML = opt.innerHTML
          # update selected index value
          @selectedIdx = idx
          # update original select element´s value
          @elOriginal.value = @elOriginal.children[@selectedIdx].value
      else if @type == 'input'
        @getinput.blur()
        @toggle.innerHTML = if @getinput.value.trim() != '' then @getinput.value else @getinput.getAttribute('placeholder')
        @elOriginal.value = @getinput.value
      return
  # add to global namespace
  window.NLForm = NLForm
  return