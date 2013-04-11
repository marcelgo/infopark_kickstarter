module Authorization
  extend ActiveSupport::Concern

  included do
    before_filter :check_authorization
  end

  private

  def check_authorization
    unless authorized?
      redirect_to_login_page
    end
  end

  # Checks if the request is authorized to display the page. This method can
  # be customized to check for user roles, for example.
  def authorized?
    current_user.logged_in?
  end

  # The user is redirected to the login page and the return_to parameter is
  # set, so that the user returns to the originally requested page after
  # a successfull login.
  def redirect_to_login_page
    target = cms_path(homepage.login_page, return_to: request.path)

    redirect_to(target, alert: I18n.t(:'flash.authorization_failed'))
  end

  def homepage
    if @obj.respond_to?(:homepage)
      @obj.homepage
    else
      Homepage.for_hostname(request.host)
    end
  end
end