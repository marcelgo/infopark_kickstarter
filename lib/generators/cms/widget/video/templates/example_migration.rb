class CreateBoxVideoExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= homepage_path %>')

    create_obj(
      _path: box_path,
      _obj_class: '<%= obj_class_name %>',
      title: 'BoxVideo',
      video_link: [{ url: 'http://www.youtube.com/watch?v=MkwfwkcbT2s' }]
    )

    puts "Created '<%= obj_class_name %>' object at '#{box_path}'..."
  end

  private

  def box_path
    "<%= cms_path %>/box-video-example"
  end
end