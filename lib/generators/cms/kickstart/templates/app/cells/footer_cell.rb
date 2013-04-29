class FooterCell < Cell::Rails
  helper :cms

  cache :show, if: :really_cache? do |cell, page|
    [
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id,
    ]
  end

  def show(page)
    @page = page
    homepage = page.homepage

    @footer_links = if homepage
      homepage.footer_links
    else
      RailsConnector::LinkList.new(nil)
    end

    render
  end

  private

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end