class Box::BoxTabsCell < BoxCell
  helper :cms

  def tab(tab, index)
    @tab = tab
    @index = index
    @class_name = index == 0 ? 'active' : nil

    render
  end

  def content(tab, index)
    @tab = tab
    @index = index
    @class_name = index == 0 ? 'active' : nil

    render
  end
end