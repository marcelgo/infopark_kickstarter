class GoogleMap.Model.Map
  constructor: (options = {})->
    @mapType = options.map_type ? 'ROADMAP'
    @latitude = options.latitude ? 0
    @longitude = options.longitude ? 0
    @domIdentifier = options.dom_identifier ? 'map'

    for data in options.pins
      @addPin(data)

  init: ->
    map = @getMap()
    pins = @getPins()

    # Use the map data as a pin, if there are no pins given.
    if pins.length == 0
      @addPin(
        latitude: @latitude
        longitude: @longitude
      )

    @placePins(map, pins)
    @fitToPins(map, pins)

  getMap: ->
    @map ||= new google.maps.Map(
      document.getElementById(@domIdentifier),
      mapTypeId: eval("google.maps.MapTypeId.#{@mapType}")
    )

  getPins: ->
    @pins ||= new Array()

  addPin: (data)->
    pin = new GoogleMap.Model.Pin(data)
    @getPins().push(pin)

  placePins: (map, pins)->
    for pin in pins
      pin.setInfoWindow(map)
      pin.setMap(map)

  fitToPins: (map, pins)->
    bounds = new google.maps.LatLngBounds()

    for pin in pins
      latLng = pin.getBounds()
      bounds.extend(latLng)

    # Extend the boundary a little bit if there they are too close to adjust the zoom level.
    if bounds.getNorthEast().equals(bounds.getSouthWest())
      delta = 0.01
      latLng1 = new google.maps.LatLng(
        bounds.getNorthEast().lat() + delta,
        bounds.getNorthEast().lng() + delta
      )

      latLng2 = new google.maps.LatLng(
        bounds.getNorthEast().lat() - delta,
        bounds.getNorthEast().lng() - delta
      )

      bounds.extend(latLng1)
      bounds.extend(latLng2)

    map.fitBounds(bounds)