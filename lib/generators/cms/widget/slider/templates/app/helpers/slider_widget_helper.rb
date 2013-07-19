module SliderWidgetHelper
  def slider_images(widget)
    widget.images
  end

  def slider_id(widget)
    widget.id
  end

  def slider_image_class_name(index)
    index == 0 ? 'active' : nil
  end

  def slider_indicator_class_name(index)
    index == 0 ? 'active' : nil
  end

  def slider_direction(direction)
    if direction == :prev
      render(view: 'left_control')
    else
      render(view: 'right_control')
    end
  end
end