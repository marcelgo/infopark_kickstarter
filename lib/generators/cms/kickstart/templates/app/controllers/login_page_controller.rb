class LoginPageController < CmsController
  include RailsConnector::Crm::Localizable

  def index
    @presenter = LoginPresenter.new(params[:login_presenter])

    if request.post? && @presenter.valid?
      login
    elsif request.delete?
      logout
    end
  end

  private

  def login
    self.current_user = @presenter.authenticate

    if current_user.logged_in?
      target = params[:return_to] || cms_path(@obj.redirect_after_login)

      redirect_to(target, notice: t(:'flash.login.success'))
    end
  end

  def logout
    reset_session

    target = cms_path(@obj.redirect_after_logout)

    redirect_to(target, notice: t(:'flash.logout.success'))
  end
end