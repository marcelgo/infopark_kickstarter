class TourController < CmsController
  def index
    if request.xhr?
      render(:modal, layout: false)
    end
  end
end