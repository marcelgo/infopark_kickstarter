class SearchCell < Cell::Rails
  helper :cms

  # Cell actions:

  def form(page, query)
    @query = query
    homepage = page.homepage

    if homepage
      @search_page = homepage.search_page

      render
    end
  end

  def results(query, hits)
    @query = query
    @hits = hits

    if @hits.present?
      render(view: 'hits')
    else
      render(view: 'no_hits')
    end
  end

  # Cell states:

  def hit(hit)
    @hit = hit

    render
  end
end