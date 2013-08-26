class SlideshareWidget < Obj
  cms_attribute :source, type: :linklist

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget

  def embed_html
    @embed_html ||= if source.present?
      data = embedded_information(source.first.url)

      data && data['html'].html_safe
    end
  end

  private

  def embedded_information(slide_url)
    url = slideshare_url(slide_url)
    json = RestClient.get(url)

    JSON.parse(json)
  rescue RestClient::ResourceNotFound
  end

  def slideshare_url(slide_url)
    params = {
      url: slide_url,
      format: 'json',
    }

    "http://www.slideshare.net/api/oembed/2?#{params.to_param}"
  end
end