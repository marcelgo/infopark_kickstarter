class Widget::SliderWidgetCell < WidgetCell
  # Cell actions:

  def show(page, widget)
    @id = widget.id
    @images = widget.images

    if @images.blank?
      @images = placeholder_images
    end

    super(page, widget)
  end

  def image(image, index)
    @image = image
    @index = index
    @class_name = index == 0 ? 'active' : nil

    render
  end

  # Cell states:
  # The following states assume @id and @images to be given.

  def indicators
    render
  end

  def images
    render
  end

  def control(direction)
    @direction = direction

    if @direction == :prev
      render(view: 'left_control')
    else
      render(view: 'right_control')
    end
  end

  def javascript_id
    "##{@id}"
  end

  # The following states assume @image to be given.

  def title
    if @image.title.present?
      render
    end
  end

  private

  def placeholder_images
    RailsConnector::LinkList.new([
      {
        url: 'http://lorempixel.com/1600/300/abstract',
        title: 'Placeholder - Use "Open in admin GUI" to select images"',
      },
    ])
  end
end