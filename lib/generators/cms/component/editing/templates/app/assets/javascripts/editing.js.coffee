jQuery ->
  editingNavbar = {
    activate: () ->
      $('#editing-inactive').show()

    deactivate: () ->
      $('#editing-inactive').hide()
  }

  editingNavbar.activate()

  $('a#edit-toggle').on 'click', ->
    if infopark.editing.is_active()
      infopark.editing.deactivate()
      editingNavbar.activate()
    else
      infopark.editing.activate()
      editingNavbar.deactivate()

  infopark.on 'new_content', ->
    cmsEditEnums = $('[data-ip-field-type=enum], [data-ip-field-type=multienum]')

    for cmsEditEnum in cmsEditEnums
      $(cmsEditEnum).on 'focusout', ->
        cmsEditEnum.infopark('save', $(cmsEditEnum).val())


    cmsEditDates = $('[data-ip-field-type=date]')

    for cmsEditDate in cmsEditDates
      dateField = $(cmsEditDate).find('input[type=text]')

      $(dateField).datepicker(format: 'yyyy-mm-dd').on 'hide', (event) ->
        date = event.date

        # Set date hour to 12 to work around complex time zone handling.
        date.setHours(12)

        $(cmsEditDate).infopark('save', date)
