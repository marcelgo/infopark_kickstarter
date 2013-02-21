# Create namespace for google maps classes.
@GoogleMap ?=
  Model: {}

class GoogleMap.App
  constructor: (selector)->
    for element in $(selector)
      url = element.getAttribute('data-url')
      id = element.id

      options =
        type: 'GET'
        dataType: 'json'
        success: (data) => @loadCallback(data)

      $.ajax(url, options)

  loadCallback: (data)->
    new GoogleMap.Model.Map(data).init()