class GoogleAnalyticsCell < Cell::Rails
  # Cell actions:

  def javascript(tracking_id, anonymize)
    @tracking_id = tracking_id
    @anonymize = anonymize

    if Rails.env.production?
      render
    end
  end

  # Cell states:
  # The following states assume @anonymize and @tracking_id to be given and that they are
  # rendered in a javascript context.

  def tracking_id
    if @tracking_id.present?
      render(format: :js)
    end
  end

  def anonymize
    if @anonymize
      render(format: :js)
    end
  end
end