class BoxCell < Cell::Rails
  helper :cms

  build do |page, box|
    "Box::#{box.class}Cell".constantize
  end

  def show(page, box)
    @page = page
    @box = box

    render
  end

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end