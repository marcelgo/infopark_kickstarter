$ ->
  ###
  # This file integrates a simple text input field to edit string attributes.
  ###

  infopark.on 'editing', ->
    template = ->
      $('<div class="string-editor-box">
         <input type="text" class="string-editor" />
         </div>')

    getBox = (element) ->
      element.closest('.string-editor-box')

    editMarker = (cmsField) ->
      cmsField.closest('[data-ip-widget-obj-class]').find('.ip_editing_marker')

    save = (e) ->
      inputField = $(e.currentTarget)
      content = inputField.val()
      box = getBox(inputField)
      cmsField = box.data('cmsField')

      box.addClass('saving')

      cmsField.infopark('save', content).done ->
        cmsField.html(content)
        disableEditMode(box, cmsField)
      .fail ->
        box.removeClass('saving')

    disableEditMode = (box, cmsField) ->
      cmsField.show()
      editMarker(cmsField).show()
      box.remove()

    cancel = (e) ->
      box = getBox($(e.currentTarget))
      cmsField = box.data('cmsField')

      disableEditMode(box, cmsField)

    keyUp = (e) ->
      key = event.keyCode || event.which
      switch key
        when 13 # Enter
          save(e)
        when 27 # Esc
          cancel(e)

    $('body').on 'click', '[data-ip-field-type=string]', (e) ->
      e.preventDefault()

      cmsField = $(this)
      template()
        .data('cmsField', cmsField)
        .insertAfter(cmsField)
        .find('input')
        .val(cmsField.infopark('content') || '')
        .focusout(save)
        .keyup(keyUp)
        .focus()

      cmsField.hide()
      editMarker(cmsField).hide()