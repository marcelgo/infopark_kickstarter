class LoginPageController < CmsController
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
      target = params[:return_to] || cms_path(@obj.homepage)

      redirect_to(target, notice: t(:'flash.login.success'))
    end
  end

  def logout
    discard_user

    target = cms_path(@obj.homepage)

    redirect_to(target, notice: t(:'flash.logout.success'))
  end
end