class VideoWidget < Obj
  include Widget

  include Cms::Attributes::VideoLink
  include Cms::Attributes::VideoWidth
  include Cms::Attributes::VideoHeight
  include Cms::Attributes::VideoAutoplay
  include Cms::Attributes::VideoPreviewImage
  include Cms::Attributes::SortKey

  # Overrides method from +Cms::Attributes::VideoHeight+.
  #
  # Determines height of the video. Either returns the height given by the
  # editor or calculates the correct ratio.
  def video_height
    if super != 0
      super
    else
      height_ratio
    end
  end

  # Determines the mime type of the video if it is stored in the CMS.
  def video_mime_type
    if video_link.present? && video_link.first.internal?
      video_link.first.destination_object.mime_type
    end
  end

  def video_provider
    if video.present?
      video.provider
    else
      'generic'
    end
  end

  def video_url
    if video.present?
      autoplay = video_autoplay? ? '1' : '0'

      "#{video.embed_url}?autoplay=#{autoplay}"
    else
      video_link.first
    end
  end

  private

  def height_ratio
    if video && video.width.present? && video.height.present?
      video_width * video.height / video.width
    else
      video_width * 2 / 3
    end
  end

  def video
    @video ||= if video_link.present?
      VideoInfo.get(video_link.first.url)
    end
  end
end