class CreateBlogExample < ::RailsConnector::Migration
  def up
    blog_path = '<%= cms_path %>/blog'

    create_obj(
      _path: blog_path,
      _obj_class: '<%= blog_class_name %>',
      title: 'Blog Page Example',
      '<%= blog_description_attribute_name %>' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    )

    entry_path = "#{blog_path}/entry-1"

    create_obj(
      _path: entry_path,
      _obj_class: '<%= blog_entry_class_name %>',
      title: 'Nulla viverra metus vitae nunc iaculis dignissim',
      "<%= blog_entry_author_attribute_name %>" => ''
    )

    create_obj(
      _path: "#{entry_path}/_boxes",
      _obj_class: 'Container',
    )

    create_obj(
      _path: "#{entry_path}/_boxes/text-1",
      _obj_class: 'BoxText',
      body: 'Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
        urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
        accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
        sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
        volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
        netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
        Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
        ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.',
    )
  end
end