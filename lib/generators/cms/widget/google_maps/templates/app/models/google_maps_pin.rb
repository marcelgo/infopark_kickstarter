class GoogleMapsPin < Obj
  include Cms::Attributes::GoogleMapsAddress

  def as_json(options = {})
    {
      :title => self.title,
      :body => self.body,
      :latitude => self.latitude,
      :longitude => self.longitude,
    }
  end
end