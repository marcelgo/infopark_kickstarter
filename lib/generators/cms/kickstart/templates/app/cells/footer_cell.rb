class FooterCell < Cell::Rails
  # Cell actions:

  def show(page)
    @page = page

    render
  end
end