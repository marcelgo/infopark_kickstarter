class CreateFormBuilderExample < ::RailsConnector::Migration
  def path
    '<%= cms_path %>/form-builder'
  end

  def up
    create_obj(
      _path: path,
      _obj_class: '<%= class_name %>',
      title: 'Contact',
      '<%= crm_activity_type_attribute_name %>' => '<%= activity_type %>',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )

    setup_crm
  end

  def setup_crm
    Infopark::Crm::CustomType.find('<%= activity_type %>')
  rescue ActiveResource::ResourceNotFound
    custom_attributes = [
      { name: 'email', title: 'Email Adress', type: 'string' },
      { name: 'message', title: 'Message', type: 'text', max_length: 1000 }
    ]

    Infopark::Crm::CustomType.create(
      kind: 'Activity',
      name: '<%= activity_type %>',
      states: ['open', 'closed'],
      icon_css_class: 'omc_activity_23',
      custom_attributes: custom_attributes
    )
  end
end