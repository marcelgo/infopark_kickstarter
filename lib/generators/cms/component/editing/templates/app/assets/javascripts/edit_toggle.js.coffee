$ ->
  if $('#edit-toggle')
    $('body').addClass('ip_editing_active')

  $('#edit-toggle a').on 'click', ->
    if infopark.editing.is_active()
      infopark.editing.deactivate()
    else
      infopark.editing.activate()