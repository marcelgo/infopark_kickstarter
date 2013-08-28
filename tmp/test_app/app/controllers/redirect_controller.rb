class RedirectController < CmsController
  def index
    if @obj.redirect_link.present?
      target = cms_path(@obj.redirect_link.first, request.query_parameters)

      redirect_to(target)
    else
      flash.now[:alert] = I18n.t('redirect.index.link_undefined')
    end
  end
end