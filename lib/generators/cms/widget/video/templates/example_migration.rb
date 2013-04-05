class CreateVideoWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    widget = create_obj(
      _path: "_widgets/#{homepage.id}/#{SecureRandom.hex(8)}",
      _obj_class: '<%= obj_class_name %>',
      title: '<%= obj_class_name %>',
      video_link: [{ url: 'http://www.youtube.com/watch?v=MkwfwkcbT2s' }]
    )

    add_widget(homepage, :main_content, widget)
  end

  private

  def add_widget(obj, attribute, widget)
    widgets = obj.widgets(attribute)

    list = widgets.inject([]) do |values, widget|
      values << {widget: widget['id']}
    end

    list << {widget: widget['id']}

    update_obj(obj.id, attribute => {
      layout: list,
    })
  end
end