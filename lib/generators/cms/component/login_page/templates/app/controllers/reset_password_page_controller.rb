class ResetPasswordPageController < CmsController
  def index
    @presenter = ResetPasswordPresenter.new(params[:reset_password_presenter])

    if request.post? && @presenter.valid?
      send_new_password(@presenter)
    end
  end

  private

  def send_new_password(presenter)
    contact = @presenter.find_contact
    target_path = cms_path(@obj.homepage.login_page)

    if contact.present?
      contact.password_request

      redirect_to(target_path, notice: t('flash.reset_password.success'))
    else
      redirect_to(target_path, alert: t('flash.reset_password.failed'))
    end
  end
end