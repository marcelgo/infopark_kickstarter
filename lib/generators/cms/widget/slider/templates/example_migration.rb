class CreateBoxSliderExample < ::RailsConnector::Migrations::Migration
  def up
    path = '<%= cms_path %>/box-slider-example'

    create_obj(
      _path: path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxSlider',
      '<%= slider_images_attribute_name %>' => [
        { url: 'http://lorempixel.com/700/350/sports', title: 'Lorem Ipsum 1' },
        { url: 'http://lorempixel.com/700/350/sports', title: 'Lorem Ipsum 2' },
      ]
    )

    puts "Created '<%= obj_class_name %>' object at '#{path}'..."
  end
end