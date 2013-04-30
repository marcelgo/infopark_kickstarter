class FormBuilderCell < Cell::Rails
  helper :cms

  # Cell actions:

  def show(presenter, obj)
    @obj = obj
    @presenter = presenter
    @custom_attributes = presenter.definition.custom_attributes

    render
  end

  # Cell states:

  def input(form, attribute)
    @form = form
    @attribute = attribute
    @type, @name, @title, @mandatory = attribute.attributes.slice('type', 'name', 'title', 'mandatory').values
    @options = send(@type)

    render
  end

  private

  def enum
    {
      as: :radio_buttons,
      collection: @attribute.attributes['valid_values'],
      label: @title,
      required: @mandatory,
    }
  end

  def text
    {
      as: :text,
      label: @title,
      input_html: {
        maxlength: @attribute.attributes['max_length'],
        rows: 10,
        class: 'span5',
      },
      required: @mandatory,
    }
  end

  def string
    {
      label: @title,
      input_html: {
        maxlength: @attribute.attributes['max_length'],
      },
      required: @mandatory,
    }
  end

  def multienum
    {
      as: :check_boxes,
      collection: @attribute.attributes['valid_values'],
      label: @title,
      required: @mandatory,
    }
  end
end