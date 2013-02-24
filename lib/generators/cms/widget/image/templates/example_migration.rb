class CreateImageWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    homepage = Obj.find_by_path(homepage_path)

    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxImage',
      caption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      link_to: [{ obj_id: homepage.id }],
      source: [{ url: 'http://lorempixel.com/660/370/sports/1/' }]
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-image-example"
  end

  def website_path
    '/website'
  end

  def homepage_path
    "#{website_path}/de"
  end
end