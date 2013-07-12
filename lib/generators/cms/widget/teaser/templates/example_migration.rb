class CreateTeaserWidgetExample < RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_obj_path %>")

    add_widget(homepage, "<%= example_obj_widget_attribute %>", {
      _obj_class: "<%= obj_class_name %>",
      headline: 'Mauris semper purus nec lorem vulputate tempor',
      content: '<p>Donec mollis turpis vitae tortor aliquam pulvinar. In malesuada mi eget mollis
        euismod. Donec mollis quam quis est ultrices, id volutpat neque sagittis. Vivamus ac neque
        non diam egestas bibendum. Nunc molestie fringilla laoreet. Fusce interdum mollis augue id
        fermentum. Fusce nec odio elementum, scelerisque nibh bibendum, eleifend odio. Sed sed
        placerat arcu, a auctor ligula. Vivamus feugiat faucibus euismod.</p>',
      link_to: [{
        title: 'Infopark Dev',
        url: 'http://dev.infopark.de',
      }],
    })
  end

  def add_widget(obj, attribute, widget_params)
    widget_params.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget_params)

    widgets = obj.widgets(attribute)

    list = widgets.inject([]) do |values, widget|
      values << { widget: widget['id'] }
    end

    list << { widget: widget['id'] }

    update_obj(obj.id, attribute => { layout: list })
  end
end