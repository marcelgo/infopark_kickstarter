class BoxVideo < Obj
  include Cms::Attributes::VideoFile
  include Cms::Attributes::VideoLink
  include Cms::Attributes::VideoWidth
  include Cms::Attributes::VideoHeight
  include Cms::Attributes::VideoAutoplay
  include Cms::Attributes::SortKey
  include Box

  def width
    video_width.to_i
  end

  def height
    return video_height if video_height.present?

    ratio(video_width)
  end

  def title
    super || video.title
  end

  def body
    super || video.description
  end

  def video
    @video ||= VideoInfo.get(first_video_link.url)
  end

  private

  def ratio(width)
    if video.width.present? && video.height.present?
      width * video.height / video.width
    else
      width / 3 * 2
    end
  end
end