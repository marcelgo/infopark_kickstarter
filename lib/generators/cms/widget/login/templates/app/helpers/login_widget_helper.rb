module LoginWidgetHelper
  def current_user_logged_in?(current_user)
    current_user.logged_in?
  end

  def current_user_login(current_user)
    current_user_login ||= current_user.fetch.login
  end

  def login_page(page)
    if page && page.homepage
      page.homepage.login_page
    end
  end
end