$ ->
  # To start the tour we use a link pointing to a CMS Tour object. The link has
  # to end with "#tour" and its href is used to load the content.
  $('a[href$="#tour"]').on 'click', (event) ->
    event.preventDefault()

    url = $(this).attr('href')
    Tour.start(url)