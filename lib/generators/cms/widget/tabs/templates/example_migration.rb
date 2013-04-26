class CreateBoxTabsExample < ::RailsConnector::Migrations::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxTab',
    )

    create_obj(
      _path: box_path + "/tab1",
      _obj_class: '<%= tab_class_name %>',
      title: 'Tab 1',
      body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    )

    create_obj(
      _path: box_path + "/tab2",
      _obj_class: '<%= tab_class_name %>',
      title: 'Tab 2',
      body: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-tabs-example"
  end
end