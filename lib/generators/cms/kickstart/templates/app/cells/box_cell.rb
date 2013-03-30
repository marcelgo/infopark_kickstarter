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
end