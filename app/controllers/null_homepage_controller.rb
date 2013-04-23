class NullHomepageController < CmsController
  def index
    flash.now[:notice] = '<h3>Infopark Platform. Up and Running.</h3><p>The current working copy
      does not have a homepage. Please select a different working copy using the button below or
      the controls above.</p><p><a class="btn btn-primary" href="/?ws=rtc">Switch Working Copy</a>
      </p>'.html_safe

    render(nothing: true, layout: true)
  end

  def self.use_for_obj_dispatch?
    true
  end
end