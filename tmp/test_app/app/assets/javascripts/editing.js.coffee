jQuery ->
  infopark.on 'new_content', ->
    elements = $('.editing').find('[data-ip-field-type=enum], [data-ip-field-type=multienum]')

    for element in elements
      $(element).on 'focusout', ->
        element.infopark('save', $(element).val()).then ->



    cmsEditDates = $('.editing').find('[data-ip-field-type=date]')
    for cmsEditDate in cmsEditDates
      dateField = $(cmsEditDate).find('input[type=text]')

      $(dateField).datepicker(format: 'yyyy-mm-dd').on 'hide', (event) ->
        date = event.date
        # Set date hour to 12 cause of time zones
        date.setHours(12)
        $(cmsEditDate).infopark('save', date)
