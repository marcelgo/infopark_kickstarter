jQuery ->
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
