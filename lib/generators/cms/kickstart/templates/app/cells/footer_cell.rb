class FooterCell < Cell::Rails
  helper :cms

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
end