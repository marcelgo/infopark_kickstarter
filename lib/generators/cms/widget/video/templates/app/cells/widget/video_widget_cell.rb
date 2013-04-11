class Widget::VideoWidgetCell < WidgetCell
  helper :cms

  def video(widget)
    return unless widget.video_link.present?

    locals = {
      width: widget.video_width,
      height: widget.video_height,
      src: widget.video_url,
    }

    if widget.video_provider == 'generic'
      locals.merge!({
        id: widget.id,
        mime_type: widget.video_mime_type,
        autoplay: widget.video_autoplay?.to_s,
        preview: widget.video_preview_image.first,
      })
    end

    view = widget.video_provider.downcase
    render(view: view, locals: locals)
  end
end