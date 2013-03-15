class GoogleAnalyticsCell < Cell::Rails
  cache :show, expires_in: 5.minutes do |cell, page|
    [
      Filters::EnvironmentDetection.preview_environment?,
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
end