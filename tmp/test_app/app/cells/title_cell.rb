class TitleCell < Cell::Rails
  # Cell actions:

  def show(obj)
    if obj
      @title = obj.title

      render
    end
  end
end