class ResetPasswordPageController < CmsController
  def index
    @presenter = ResetPasswordPresenter.new(params[:reset_password_presenter])

    if request.post? && @presenter.valid?
      handle_redirect(@presenter.password_request, @obj)
    end
  end

  private

  def handle_redirect(status, target)
    options = {}

    if status
      target = target.homepage
      options[:notice] = t('flash.reset_password.success')
    else
      options[:alert] = t('flash.reset_password.failed')
    end

    target_path = cms_path(target)
    redirect_to(target_path, options)
  end
end