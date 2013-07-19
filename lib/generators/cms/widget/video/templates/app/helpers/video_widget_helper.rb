module VideoWidgetHelper
  def video_provider_partial_path(widget)
    "video_widget/views/#{widget.provider.downcase}"
  end

  def video_partial_attributes(widget)
    {
      width: widget.width,
      height: widget.height,
      src: widget.embed_url,
      id: widget.id,
      mime_type: widget.mime_type,
      autoplay: widget.autoplay?,
      poster: widget.poster,
    }
  end
end