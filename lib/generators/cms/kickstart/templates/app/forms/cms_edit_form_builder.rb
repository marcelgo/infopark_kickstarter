class CmsEditFormBuilder < SimpleForm::FormBuilder
  def text_field(attribute_name, html_options)
    template.cms_tag(:div, @object, attribute_name, html_options)
  end

  def collection_select(attribute_name, collection, value_method, label_method, options = {}, html_options = {})
    template.cms_tag(:select, @object, attribute_name, html_options) do |tag|
      template.cms_options_for_select(@object, attribute_name)
    end
  end
end