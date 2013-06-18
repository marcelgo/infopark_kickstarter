class BreadcrumbsCell < Cell::Rails
  # Cell actions:

  def show(obj)
    @page = obj

    if @page.is_a?(Page) && @page.show_breadcrumbs?
      @breadcrumbs = @page.breadcrumbs

      render
    end
  end

  # Cell states:
  # The following states assume @page to be given.

  def item(obj)
    @obj = obj
    @title = obj.menu_title

    if @page == @obj
      render view: 'active'
    else
      render view: 'ancestor'
    end
  end
end