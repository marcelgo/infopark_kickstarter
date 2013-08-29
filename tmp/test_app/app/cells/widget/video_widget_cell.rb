class Widget::VideoWidgetCell < WidgetCell
  helper :cms

  # Cell states:
  # The following states assume @widget to be given.

  def video
    return unless @widget.source.present?

    @width = @widget.width
    @height = @widget.height
    @src = @widget.embed_url

    render(state: @widget.provider.downcase)
  end

  # The following states assume @widget, @width, @height and @src to be given.

  def projekktor
    @id = @widget.id
    @mime_type = @widget.mime_type
    @autoplay = @widget.autoplay?
    @poster = @widget.poster

    render
  end

  def vimeo
    render
  end

  def youtube
    render
  end
end