class MetaNavigationCell < Cell::Rails
  helper :cms

  cache(:show, if: :really_cache?) do |cell, page, current_user|
    [
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id,
      current_user && current_user.id,
    ]
  end

  def show(page, current_user)
    @current_user = current_user
    homepage = page.homepage

    if homepage
      @login_page = homepage.login_page

      render
    end
  end

  private

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end