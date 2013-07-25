class TourStepController < CmsController
  def index
    redirect_to cms_path(@obj.parent)
  end
end