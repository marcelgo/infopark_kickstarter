class Widget::LoginWidgetCell < WidgetCell
  include Authentication

  def show(page, widget)
    @page = page
    @widget = widget
    @current_user = current_user

    unless @current_user.logged_in?
      render view: 'login_form'
    else
      render
    end
  end

  # states
  def logout
    if @page.homepage && @page.homepage.login_page_link?
      @login_page = @page.homepage.login_page

      render
    end
  end

  private

  def session
    request.session
  end
end