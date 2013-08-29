class ProfilePageController < CmsController
  include Authorization

  def index
    @presenter = ProfilePagePresenter.new(current_user, params[:profile_page_presenter])

    if request.post? && @presenter.save
      flash.now[:notice] = I18n.t('flash.profile_page.success')
    end
  end
end