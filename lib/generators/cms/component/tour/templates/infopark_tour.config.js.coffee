$ ->
  InfoparkTour.init()

  $('.widget.teaser a[href$="#tour"]').on 'click', (event) ->
    event.preventDefault()
    InfoparkTour.show()