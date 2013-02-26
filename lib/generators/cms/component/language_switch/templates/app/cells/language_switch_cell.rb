class LanguageSwitchCell < Cell::Rails
  helper :cms

  def show(homepages, current_homepage)
    @homepages = homepages
    @current_homepage = current_homepage

    render
  end

  def entry(homepage)
    @homepage = homepage

    render
  end

  private

  def current_homepage?(homepage)
    homepage == @current_homepage
  end
  helper_method :current_homepage?
end