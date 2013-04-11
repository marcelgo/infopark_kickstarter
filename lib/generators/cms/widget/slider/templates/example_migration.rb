class CreateSliderWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    add_widget(homepage, :main_content, {
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxSlider',
      '<%= slider_images_attribute_name %>' => [
        { url: 'http://lorempixel.com/700/350/sports', title: 'Lorem Ipsum 1' },
        { url: 'http://lorempixel.com/700/350/sports', title: 'Lorem Ipsum 2' },
      ],
    })
  end

  private

  def add_widget(obj, attribute, widget)
    widget.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget)

    widgets = obj.widgets(attribute)

    list = widgets.inject([]) do |values, widget|
      values << {widget: widget['id']}
    end

    list << {widget: widget['id']}

    update_obj(obj.id, attribute => {
      layout: list,
    })

    puts "Created '#{widget[:_obj_class]}'..."
  end
end