# Create namespace for google maps classes.
@GoogleMap ?=
  Model: {}

class GoogleMap.App
  constructor: (selector)->
    for element in $(selector)
      url = element.getAttribute('data-url')

      options =
        type: 'GET'
        dataType: 'json'
        success: (data) ->
          new GoogleMap.Model.Map(data).init()

      $.ajax(url, options)