class Box::BoxVideoCell < BoxCell
  helper :cms

  def video(box)
    locals = {
      width: box.video_width,
      height: box.video_height,
      src: box.video_url,
    }

    if box.video_provider == 'generic'
      locals.merge!({
        id: box.id,
        mime_type: box.video_mime_type,
        autoplay: box.video_autoplay?.to_s,
        preview: box.video_preview_image.first,
      })
    end

    view = box.video_provider.downcase
    render(view: view, locals: locals)
  end
end