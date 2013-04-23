class FormBuilderCell < Cell::Rails
  def show(presenter, obj)
    @obj = obj
    @presenter = presenter
    @custom_attributes = presenter.definition.custom_attributes

    render
  end

  # Cell states

  def element(form, attribute)
    @form = form
    @attribute = attribute
    @type, @name, @title, @mandatory = attribute.attributes.slice('type', 'name', 'title', 'mandatory').values

    render
  end

  def enum_element
    @valid_values = @attribute.attributes['valid_values']

    render
  end

  def text_element
    @max_length = @attribute.attributes['max_length']

    render
  end

  def string_element
    @max_length = @attribute.attributes['max_length']

    render
  end

  def multienum_element
    @valid_values = @attribute.attributes['valid_values']

    render
  end

end