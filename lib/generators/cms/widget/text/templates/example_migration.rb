class CreateTextWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxText',
      body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-text-example"
  end
end