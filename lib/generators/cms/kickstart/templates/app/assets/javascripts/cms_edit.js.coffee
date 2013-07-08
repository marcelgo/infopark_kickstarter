$ ->
  infopark.on 'new_content', ->
    elements = infopark.enum_field_element.all().concat infopark.multienum_field_element.all()
    _.each elements, (element) ->
      input = element.dom_element()
      input.focusout ->
        input.addClass 'saving'
        input.infopark('save', input.val()).then ->
          input.removeClass 'saving'