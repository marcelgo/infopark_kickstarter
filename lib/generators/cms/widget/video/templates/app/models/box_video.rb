class BoxVideo < Obj
  include Cms::Attributes::VideoLink
  include Cms::Attributes::VideoWidth
  include Cms::Attributes::VideoHeight
  include Cms::Attributes::VideoAutoplay
  include Cms::Attributes::VideoPreviewImage
  include Cms::Attributes::SortKey
  include Box

  def title
    super || video.title
  end

  def body
    super || video.description
  end

  def video
    @video ||= VideoInfo.get(first_video_link.url)
  end

  def video_url
    value = if video_autoplay?
      '1'
    else
      '0'
    end

    case video_provider
    when 'YouTube'
      video.embed_url << "?autoplay=#{value}"
    when 'Vimeo'
      video.embed_url << "?autoplay=#{value}"
    when 'generic'
      'http:' << first_video_link.destination_object.body_data_url
    end
  end

  def video_mime_type
    first_video_link.destination_object.mime_type
  end

  def video_preview_url?
    first_video_preview_image.present?
  end

  def video_preview_url
    if video_preview_url?
      'http:' << first_video_preview_image.destination_object.body_data_url
    end
  end

  def video_provider?
    video_provider.present?
  end

  def video_provider
    if first_video_link.internal?
      @video_provider ||= 'generic'
    elsif first_video_link.external?
      if video.present?
        @video_provider ||= video.provider 
      end
    end
  end
end