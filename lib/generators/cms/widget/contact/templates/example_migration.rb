class CreateContactWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxContact',
      contact_id: 'example-id'
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-contact-example"
  end
end