class Widget::LoginWidgetCell < WidgetCell
  include Authentication

  # Cell actions:

  def show(page, widget)
    @page = page
    @widget = widget
    @current_user = current_user

    if @current_user.logged_in?
      @login = @current_user.fetch.login

      render
    else
      @login_page = login_page(@page)

      if @login_page
        render(view: 'form')
      end
    end
  end

  # Cell states:
  # The following states assume @page to be given.

  def logout
    @login_page = login_page(@page)

    if @login_page
      render
    end
  end

  # The following states assume @login_page to be given.

  def reset_password
    render
  end

  private

  def login_page(page)
    if page && page.homepage
      page.homepage.login_page
    end
  end

  def session
    request.session
  end
end