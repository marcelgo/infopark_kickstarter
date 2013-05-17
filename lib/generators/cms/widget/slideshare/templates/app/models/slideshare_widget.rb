class SlideshareWidget < Obj
  cms_attribute :content, type: :html
  cms_attribute :headline, type: :string
  cms_attribute :source, type: :linklist

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget

  def html
    json = open(json_url).read
    json_object = JSON.parse(json)

    json_object['html'].html_safe
  rescue
    ''
  end

  private

  def json_url
    "http://www.slideshare.net/api/oembed/2?url=#{url}&format=json"
  end

  def url
    self.source.first.url
  rescue
    ''
  end
end

