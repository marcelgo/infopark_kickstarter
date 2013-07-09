class GoogleMapsWidget < Obj
  cms_attribute :address, type: :string

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget

  def embed_url
    URI.escape("http://maps.google.de/maps?f=q&source=s_q&hl=de&geocode=&q=#{address}&ie=UTF8&t=m&z=14&output=embed").html_safe
  end
end