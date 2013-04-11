class GoogleAnalyticsCell < Cell::Rails
  cache :show, if: :really_cache? do |cell, page|
    [
      RailsConnector::Workspace.current.revision_id,
      page && page.homepage.id
    ]
  end

  def show(homepage)
    obj = homepage.google_analytics.destination_objects.first

    @tracking_id = obj.google_analytics_tracking_id
    @anonymize_ip = obj.google_analytics_anonymize_ip?

    if @tracking_id.present?
      render
    end
  end

  private

  def really_cache?(*args)
    RailsConnector::Workspace.current.published?
  end
end