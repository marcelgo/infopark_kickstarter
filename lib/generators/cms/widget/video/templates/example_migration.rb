class CreateVideoWidgetExample < RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_cms_path %>")

    add_widget(homepage, "<%= example_widget_attribute %>", {
      _obj_class: "<%= obj_class_name %>",
      source: [{
        url: 'https://ip-saas-infoparkdev-cms.s3.amazonaws.com/public/506c948822d39176/7d452f7d1bd716d10bcb609cbe7e3c51/getting-started.mp4'
      }],
      poster: [{
        url: 'https://ip-saas-infoparkdev-cms.s3.amazonaws.com/public/284444b2216d2bec/7e0b65a4d87d224d622a41327f07a9bd/getting-started-poster.png'
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