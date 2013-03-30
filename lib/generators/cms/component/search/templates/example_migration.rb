class CreateSearchPageExample < ::RailsConnector::Migration
  def up
    path = '<%= configuration_path %>/search'

    create_obj(
      _path: path,
      _obj_class: '<%= class_name %>',
      title: 'Search Page Example',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )

    attributes = get_obj_class('Homepage')['attributes']
    attributes << {
      name: '<%= search_page_attribute_name %>',
      type: :linklist,
      title: 'Search Page',
      max_size: 1,
    }
    update_obj_class('Homepage', attributes: attributes)

    homepage = Obj.find_by_path('<%= homepage_path %>')

    update_obj(
      homepage.id,
      '<%= search_page_attribute_name %>' => [{ url: path }]
    )
  end
end