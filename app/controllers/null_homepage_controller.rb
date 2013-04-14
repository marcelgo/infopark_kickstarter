class NullHomepageController < CmsController
  def index
    flash.now[:alert] = '<h3>Oops. Homepage missing?</h3>The application could not
      determine a homepage. Please check if your selected workspace provides a homepage when the
      "choose_homepage" callback in "config/initializers/rails_connector.rb" is executed.'.html_safe

    render nothing: true, layout: true
  end

  def self.use_for_obj_dispatch?
    true
  end
end