class CreateProfilePageExample < ::RailsConnector::Migration
  def up
    path = '<%= configuration_path %>/profile'

    create_obj(
      :_path => path,
      :_obj_class => '<%= class_name %>',
      :title => 'Profile Page Example',
      :body => '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
      '<%= show_in_navigation_attribute_name %>' => 'Yes'
    )

    attributes = get_obj_class('Homepage')['attributes']
    attributes.map do |definition|
      definition.delete('id')

      definition.delete_if do |_, value|
        value.nil?
      end
    end
    attributes << {
      name: '<%= profile_page_attribute_name %>',
      type: 'linklist',
      title:  'Profile Page',
      max_size:  1,
    }

    update_obj_class('Homepage', :attributes => attributes)

    homepage = Obj.find_by_path('<%= homepage_path %>')

    update_obj(
      homepage.id,
      '<%= profile_page_attribute_name %>' => [{ :url => path }]
    )
  end
end