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

  private

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end