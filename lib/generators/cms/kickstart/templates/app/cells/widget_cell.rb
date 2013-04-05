class WidgetCell < Cell::Rails
  helper :cms

  build do |page, widget|
    "Widget::#{widget.class}Cell".constantize
  end

  def show(page, widget)
    @page = page
    @widget = widget

    render
  end

  def edit_marker
    if edit_marker?
      render
    end
  end

  private

  def edit_marker?
    Filters::EnvironmentDetection.preview_environment?
  end
end