$ ->
  $('a#edit-toggle').on 'click', ->
    if infopark.editing.is_active()
      infopark.editing.deactivate()
    else
      infopark.editing.activate()