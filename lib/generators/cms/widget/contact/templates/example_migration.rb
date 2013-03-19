class CreateContactWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxContact',
      contact_id: Infopark::Crm::Contact.first.id
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-contact-example"
  end
end