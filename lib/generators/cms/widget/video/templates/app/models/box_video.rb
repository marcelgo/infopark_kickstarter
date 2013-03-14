class BoxVideo < Obj
  include Box

  include Cms::Attributes::VideoLink
  include Cms::Attributes::VideoWidth
  include Cms::Attributes::VideoHeight
  include Cms::Attributes::VideoAutoplay
  include Cms::Attributes::VideoPreviewImage
  include Cms::Attributes::SortKey

  def video
    @video ||= VideoInfo.get(first_video_link.url)
  end

  def video_mime_type
    if first_video_link.internal?      
      first_video_link.destination_object.mime_type
    end
  end

  def video_provider
    if first_video_link.present? && video.present?
      video.provider
    else
      'generic'
    end
  end

  def first_video_link
    video_link.first
  end
end