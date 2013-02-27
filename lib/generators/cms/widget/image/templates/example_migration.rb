class CreateImageWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxImage',
      caption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
      link_to: [{ obj_id: homepage.id }],
      source: [{ url: 'http://lorempixel.com/660/370/sports' }]
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-image-example"
  end
end