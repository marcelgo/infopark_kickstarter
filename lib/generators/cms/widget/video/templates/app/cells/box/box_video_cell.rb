class Box::BoxVideoCell < BoxCell
  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def video(box)
    video = box.video
    return if video.blank?

    if video.provider.present?
      case video.provider
      when 'YouTube'
        render(view: 'video_youtube', locals: { width: box.width, height: box.height, src: video_url(box) })
      when 'Vimeo'
        render(view: 'video_vimeo', locals: { width: box.width, height: box.height, src: video_url(box) })
      else        
        render(view: 'video_generic', locals: { video: box })
      end
    end
  end

  private

  def video_url(box)
    value = if box.video_autoplay?
      '1'
    else
      '0'
    end

    box.video.embed_url << "?autoplay=#{value}"
  end
end