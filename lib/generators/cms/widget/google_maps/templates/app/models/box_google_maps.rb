class BoxGoogleMaps < Obj
  include Cms::Attributes::GoogleMapsMapType
  include Cms::Attributes::GoogleMapsAddress

  include Box

  attr_accessor :dom_identifier

  def pins
    toclist.select { |obj| obj.is_a?(GoogleMapsPin) }
  end

  def as_json(options = {})
    {
      pins: self.pins.as_json,
      map_type: self.google_maps_map_type,
      latitude: self.latitude,
      longitude: self.longitude,
      dom_identifier: self.dom_identifier,
    }
  end
end