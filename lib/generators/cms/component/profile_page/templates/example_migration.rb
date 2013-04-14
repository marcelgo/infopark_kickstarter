class CreateProfilePageExample < ::RailsConnector::Migration
  def up
    path = '<%= cms_path %>/profile'

    create_obj(
      _path: path,
      _obj_class: '<%= obj_class_name %>',
      title: 'Profile',
      body: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )
  end
end