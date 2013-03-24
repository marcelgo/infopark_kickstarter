class CreateBoxPersonExample < ::RailsConnector::Migrations::Migration
  def up
    path = '<%= cms_path %>/box-person-example'

    create_obj(
      _path: path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxPerson',
      person: 'root'
    )

    puts "Created '<%= obj_class_name %>' object at '#{path}'..."
  end
end