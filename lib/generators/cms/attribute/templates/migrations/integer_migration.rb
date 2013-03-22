class Create<%= class_name %>Attribute < ::RailsConnector::Migration
  def up
    create_attribute(name: '<%= file_name %>', type: 'string', title: '<%= title %>')
  end
end