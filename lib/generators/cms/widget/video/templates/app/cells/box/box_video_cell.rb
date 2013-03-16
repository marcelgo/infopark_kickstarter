class Box::BoxVideoCell < BoxCell
  helper :cms

  def video(box)
    return if box.first_video_link.blank?

    locals = {
      width: box.video_width,
      height: box.video_height,
      src: video_url(box),
    }

    if box.video_provider == 'generic'
      locals.merge!({
        id: box.id,
        mime_type: box.video_mime_type,
        autoplay: box.video_autoplay?.to_s,
        preview: box.first_video_preview_image,
      })
    end

    view = box.video_provider.downcase
    render(view: view, locals: locals)
  end

  private

  def video_url(box)
    video = box.video

    case box.video_provider
    when 'YouTube', 'Vimeo'
      value = box.video_autoplay? ? '1' : '0'
      video.embed_url << "?autoplay=#{value}"
    when 'generic'
      box.video_link.first
    end
  end
end