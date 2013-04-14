class IntegrateGoogleAnalytics < ::RailsConnector::Migration
  def up
    create_configuration_obj
    deactivate_obj_class
    add_hompage_attribute
    add_homepage_configuration
  end

  private

  def path
    '<%= configuration_path %>/google_analytics'
  end

  def create_configuration_obj
    create_obj(
      _path: path,
      _obj_class: '<%= class_name %>',
      title: 'Google Analytics'
    )
  end

  def deactivate_obj_class
    update_obj_class(
      '<%= class_name %>',
      is_active: false
    )
  end

  def add_hompage_attribute
    attributes = get_obj_class('Homepage')['attributes']
    attributes.map do |definition|
      definition.delete('id')

      definition.delete_if do |_, value|
        value.nil?
      end
    end
    attributes << {
      name: '<%= homepage_configuration_attribute_name %>',
      type: 'linklist',
      title: 'Google Analytics',
      max_size: 1,
    }

    update_obj_class('Homepage', attributes: attributes)
  end

  def add_homepage_configuration
    update_obj(
      Obj.find_by_path('<%= homepage_path %>').id,
      '<%= homepage_configuration_attribute_name %>' => [{ url: path }]
    )
  end
end