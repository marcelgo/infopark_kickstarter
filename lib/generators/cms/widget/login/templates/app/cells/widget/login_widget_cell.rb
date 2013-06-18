class Widget::LoginWidgetCell < WidgetCell
  include Authentication

  # Cell actions:

  def show(page, widget)
    @page = page
    @widget = widget
    @current_user = current_user

    if @current_user.logged_in?
      render
    else
      @login_page = login_page(@page)

      render(view: 'login_form')
    end
  end

  # Cell states:
  # The following states assume @page to be given.

  def logout
    if homepage(@page) && homepage(@page).login_page_link?
      @login_page = login_page(@page)

      render
    end
  end

  # The following states assume @login_page to be given.

  def reset_password
    render
  end

  private

  def homepage(page)
    page.homepage
  end

  def login_page(page)
    homepage(page).login_page
  end

  def session
    request.session
  end
end