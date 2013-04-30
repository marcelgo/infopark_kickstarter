class FormBuilderController < CmsController
  def index
    @form = FormPresenter.new(@obj.crm_activity_type, params[:form_presenter])

    if request.post? && @form.submit
      redirect_to(cms_path(@obj), notice: I18n.t('flash.form_builder.success'))
    end
  end
end