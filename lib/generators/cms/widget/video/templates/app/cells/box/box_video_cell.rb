class Box::BoxVideoCell < BoxCell
  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def show(page, box)
    @id = "video_#{box.id}"
    super
  end

  def video(box)
    return if !box.video_provider?

    case box.video_provider
    when 'YouTube'
      render(view: 'video_youtube', locals: { width: box.video_width, height: box.video_height, src: box.video_url })
    when 'Vimeo'
      render(view: 'video_vimeo', locals: { width: box.video_width, height: box.video_height, src: box.video_url })
    when 'generic'        
      autoplay = if box.video_autoplay?
        'true'
      else
        'false'
      end

      render(view: 'video_generic', locals: { width: box.video_width, height: box.video_height, src: box.video_url, mime_type: box.video_mime_type, autoplay: autoplay, preview: box.video_preview_url })
    end
  end
end