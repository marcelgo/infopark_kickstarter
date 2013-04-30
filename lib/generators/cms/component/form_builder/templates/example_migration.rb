class CreateFormBuilderExample < ::RailsConnector::Migration
  def up
    create_obj(
      _path: '<%= cms_path %>/feedback',
      _obj_class: '<%= class_name %>',
      '<%= title_attribute_name %>' => 'Feedback',
      '<%= body_attribute_name %>' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
        do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
        nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
        irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
        anim id est laborum.',
      '<%= crm_activity_type_attribute_name %>' => '<%= activity_type %>',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )

    setup_crm
  end

  def setup_crm
    Infopark::Crm::CustomType.find('<%= activity_type %>')
  rescue ActiveResource::ResourceNotFound
    custom_attributes = [
      { name: 'email', title: 'E-mail address', type: 'string' },
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