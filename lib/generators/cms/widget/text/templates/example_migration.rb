class CreateTextWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    widget = create_obj(
      _path: "_widgets/#{homepage.id}/#{SecureRandom.hex(8)}",
      _obj_class: '<%= obj_class_name %>',
      title: '<%= obj_class_name %>',
      body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    )

    puts "Created '<%= obj_class_name %>'..."

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