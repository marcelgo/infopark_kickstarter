class CreateSearchPageExample < ::RailsConnector::Migration
  def up
    path = '<%= configuration_path %>/search'

    create_obj(
      _path: path,
      _obj_class: '<%= class_name %>',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )

    attributes = get_obj_class('Homepage')['attributes']
    attributes.map do |definition|
      definition.delete_if do |_, value|
        value.nil?
      end
    end
    attributes << {
      name: '<%= search_page_attribute_name %>',
      type: :linklist,
      title: 'Search Page',
      max_size: 1,
    }

    update_obj_class('Homepage', attributes: attributes)

    update_obj(
      Obj.find_by_path('<%= homepage_path %>').id,
      '<%= search_page_attribute_name %>' => [{ url: path }]
    )
  end
end