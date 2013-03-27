class SearchCell < Cell::Rails
  def show(page)
    @query = params[:q]
    @search_page = page.homepage.search_page

    render
  end
end