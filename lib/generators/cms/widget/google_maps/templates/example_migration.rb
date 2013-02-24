class CreateBoxGoogleMapsExample < ::RailsConnector::Migrations::Migration
  def up
    create_obj(
      _path: box_path,
      _obj_class: '<%= map_class_name %>',
      title: 'BoxGoogleMaps',
      body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      '<%= address_attribute_name %>' => 'Kitzingstrasse 12, 12277, Berlin, Germany',
      '<%= map_type_attribute_name %>' => 'ROADMAP'
    )

    puts "Created '<%= map_class_name %>' object at '#{box_path}'..."

    create_obj(
      _path: "#{box_path}/pin-1",
      _obj_class: '<%= pin_class_name %>',
      title: 'Pin 1',
      body: 'Lorem ipsum dolor sit amet.',
      '<%= address_attribute_name %>' => 'Pariser Platz 1, Berlin, Germany'
    )

    puts "Created '<%= pin_class_name %>' object at '#{box_path}/pin-1'..."

    create_obj(
      _path: "#{box_path}/pin-2",
      _obj_class: '<%= pin_class_name %>',
      title: 'Pin 2',
      body: 'Lorem ipsum dolor sit amet.',
      '<%= address_attribute_name %>' => 'Kitzingstrasse 12, 12277, Berlin, Germany'
    )

    puts "Created '<%= pin_class_name %>' object at '#{box_path}/pin-2'..."
  end

  private

  def box_path
    "<%= cms_path %>/box_google_maps"
  end
end