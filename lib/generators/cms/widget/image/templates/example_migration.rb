class CreateImageWidgetExample < ::RailsConnector::Migrations::Migration
  def up
    image_widget = create_obj(
      _path: "_widgets/#{homepage.id}/#{SecureRandom.hex(8)}",
      _obj_class: '<%= obj_class_name %>',
      title: 'ImageWidget',
      caption: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
      link_to: [{ obj_id: homepage.id }],
      source: [{ url: 'http://lorempixel.com/660/370/sports' }]
    )

    puts "Created '<%= obj_class_name %>' object"

    widgets = main_content.inject([]) do |values, widget|
      values << {widget: widget['id']}
    end

    widgets << {widget: image_widget['id']}

    update_obj(homepage.id, main_content: {
      layout: widgets
    })
  end

  private

  def main_content
    # workaround for a not yet fixed bug in the cloud_connector gem
    begin
      homepage.widgets(:main_content)
    rescue NoMethodError
      []
    end
  end

  def homepage
     Obj.find_by_path('<%= homepage_path %>')
  end
end