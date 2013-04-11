class FooterCell < Cell::Rails
  helper :cms

  cache :show, if: :really_cache? do |cell, page|
    [
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id,
    ]
  end

  def show
    render
  end

  private

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end