class CreateGoogleMapsWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_obj_path %>")

    add_widget(homepage, "<%= example_obj_widget_attribute %>", {
      _obj_class: "<%= obj_class %>",
      address: 'Infopark, Kitzingstrasse 15, 12277 Berlin'
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
