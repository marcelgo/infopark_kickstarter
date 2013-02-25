class CreateBlogExample < ::RailsConnector::Migration
  def path
    '<%= homepage_path %>/blog'
  end

  def up
    create_obj(
      _path: path,
      _obj_class: '<%= blog_class_name %>',
      title: 'Blog',
      "<%= blog_entry_truncation_attribute_name %>" => '500',
    )

    create_obj(
      _path: "#{path}/entry-1",
      _obj_class: '<%= blog_entry_class_name %>',
      title: 'Nulla viverra metus vitae nunc iaculis dignissim',
      body: 'Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
      urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
      accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
      sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
      volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
      netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
      Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
      ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.',
      "<%= blog_entry_tags_attribute_name %>" => '"General", "Fun", "Lorem"',
      "<%= blog_entry_author_id_attribute_name %>" => "",
      "<%= blog_entry_publication_date_attribute_name %>" => Time.now.strftime("%d.%m.%Y"),
    )

    create_obj(
      _path: "#{path}/entry-2",
      _obj_class: '<%= blog_entry_class_name %>',
      title: 'Quisque molestie, ante a vulputate accumsan, urna nibh congue magna.',
      body: 'Donec interdum erat vel est cursus id lacinia urna adipiscing. In non tellus diam,
      a aliquet augue. Fusce quis erat nec erat dapibus feugiat vitae et massa. Mauris pharetra
      turpis id ligula hendrerit eget condimentum tellus pharetra. Cras felis mi, sagittis sit
      amet ultrices a, egestas nec est. Maecenas vitae diam velit. Suspendisse auctor sodales
      justo. Nunc ligula sapien, scelerisque eu commodo ut, pretium quis nibh. In nec justo diam.
      Pellentesque porttitor sollicitudin augue, ac sollicitudin odio aliquet id. Ut scelerisque
      fermentum ante, eu interdum urna vehicula sed. Aenean enim risus, faucibus in dapibus vel,
      porta vitae turpis. Etiam sagittis diam in tortor commodo malesuada. Suspendisse enim lorem,
      rutrum a placerat nec, gravida sit amet risus. Praesent egestas porttitor magna a commodo.
      Praesent viverra massa ac lectus sodales ac consequat enim pharetra.',
      "<%= blog_entry_tags_attribute_name %>" => '"General", "Sport", "Ipsum"',
      "<%= blog_entry_author_id_attribute_name %>" => "",
      "<%= blog_entry_publication_date_attribute_name %>" => Time.now.strftime("%d.%m.%Y"),
    )
  end
end