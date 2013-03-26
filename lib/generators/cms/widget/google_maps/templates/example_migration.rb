class CreateGoogleMapsWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    google_maps_widget = create_obj(
      _path: widget_path,
      _obj_class: '<%= map_class_name %>',
      title: 'GoogleMapsWidget',
      body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'google_maps_address' => 'Kitzingstrasse 12, 12277, Berlin, Germany',
      'google_maps_map_type' => 'ROADMAP'
    )

    puts "Created '<%= map_class_name %>' object at '#{widget_path}'..."

    widgets = main_content.inject([]) do |values, widget|
      values << {widget: widget['id']}
    end

    widgets << {widget: google_maps_widget['id']}

    update_obj(homepage.id, main_content: {
      layout: widgets
    })
  end

  private

  def homepage
    Obj.find_by_path('/website/en')
  end

  def widget_path
    @widget_path ||= "_widgets/#{homepage.id}/#{SecureRandom.hex(8)}"
  end

  def main_content
    # workaround for a not yet fixed bug in the cloud_connector gem
    begin
      homepage.widgets(:main_content)
    rescue NoMethodError
      []
    end
  end
end