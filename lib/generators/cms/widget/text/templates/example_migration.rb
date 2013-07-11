class CreateTextWidgetExample < RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_obj_path %>")

    add_widget(homepage, "<%= example_obj_widget_attribute %>", {
      _obj_class: "<%= obj_class %>",
      content: 'Nullam sed velit libero. Nullam pharetra metus non justo lobortis, eu vehicula magna
        mollis. Suspendisse feugiat volutpat neque, eget volutpat nulla. Phasellus non ipsum ac
        ipsum venenatis iaculis. Maecenas dictum congue nulla id fringilla. Suspendisse sit amet
        enim dapibus, volutpat dui quis, suscipit nunc. Morbi imperdiet pellentesque augue, at
        ornare mauris consectetur faucibus.'
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