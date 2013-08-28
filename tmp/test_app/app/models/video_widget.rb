class VideoWidget < Obj
  include Widget

  cms_attribute :source, type: :linklist, max_size: 1
  cms_attribute :width, type: :integer
  cms_attribute :height, type: :integer
  cms_attribute :autoplay, type: :boolean
  cms_attribute :poster, type: :linklist, max_size: 1

  # Determines the mime type of the video if it is stored in the CMS.
  def mime_type
    if source.present? && source.first.internal?
      source.first.destination_object.mime_type
    end
  end

  def provider
    if video_info.present?
      video_info.provider
    else
      'projekktor'
    end
  end

  def embed_url
    if video_info.present?
      autoplay = autoplay? ? '1' : '0'

      "#{video_info.embed_url}?autoplay=#{autoplay}"
    else
      source.first
    end
  end

  private

  def video_info
    @video_info ||= if source.present?
      VideoInfo.get(source.first.url)
    end
  end
end