class Box::BoxVideoCell < BoxCell
  helper :cms

  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def video(box)
    @id = "video_#{box.id}"
    view = "video_#{box.video_provider.downcase}"

    locals = {
      width: box.video_width,
      height: box.video_height,
      src: video_url(box),
    }

    if box.video_provider == 'generic'
      locals.merge!({
        # mime_type: box.video_mime_type,
        autoplay: box.video_autoplay?.to_s,
        preview: box.first_video_preview_image,
      })
    end

    render(view: view, locals: locals)
  end

  private

  def video_url(box)
    video = box.video

    url = case box.video_provider
    when 'YouTube', 'Vimeo'
      value = video_autoplay? ? '1' : '0'
      video.embed_url << "?autoplay=#{value}"
    when 'generic'
      box.video_link.first
    end
  end
end