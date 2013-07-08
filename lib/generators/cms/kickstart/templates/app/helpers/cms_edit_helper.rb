module CmsEditHelper
  def cms_edit_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge(builder: CmsEditFormBuilder)), &block)
  end

  def cms_options_for_select(obj, attribute)
    attribute_definition = obj.cms_attribute_definition(attribute)

    options_for_select(attribute_definition['values'], obj.send(attribute))
  end
end