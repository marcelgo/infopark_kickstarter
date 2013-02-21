class GoogleMap.Model.Pin
  constructor: (data)->
    @title = data.title
    @body = data.body
    @latitude = data.latitude
    @longitude = data.longitude

  getMarker: ->
    @marker ||= new google.maps.Marker(
      position: new google.maps.LatLng(@latitude, @longitude)
      title: @title
    )

  getInfoWindow: ->
    @infoWindow ||= new google.maps.InfoWindow(
      content: @content()
    )

  getBounds: ->
    new google.maps.LatLng(@latitude, @longitude);

  setMap: (map)->
    marker = @getMarker()

    marker.setMap(map)

  setInfoWindow: (map)->
    marker = @getMarker()
    infoWindow = @getInfoWindow()

    google.maps.event.addListener(marker, 'click', ->
      infoWindow.open(map, marker)
    )

  content: ->
    contentString = ''

    if @title?
      contentString += "<h3>#{@title}</h3>"

    if @body?
      contentString += "<p>#{@body}</p>"

    contentString