class CreateTeaserWidgetExample < RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_cms_path %>")

    add_widget(homepage, "<%= example_widget_attribute %>", {
      _obj_class: "<%= obj_class_name %>",
      headline: 'Welcome to Infopark',
      content: '<p>You successfully started your
        project. Basic components such as a top navigation, a search panel, this text widget, and a
        login page have been created for you to experiment with the building blocks of your website
        application. To access the documentation or get in touch with the Infopark support team,
        visit the Dev Center.</p>',
      link_to: [{
        title: 'Browse Infopark Dev Center',
        url: 'https://dev.infopark.net/preparation',
      }],
    })
  end

  private

  def add_widget(obj, attribute, widget)
    widget.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget)

    revision_id = RailsConnector::Workspace.current.revision_id
    definition = RailsConnector::CmsRestApi.get("revisions/#{revision_id}/objs/#{obj.id}")

    widgets = definition[attribute] || {}
    widgets['layout'] ||= []
    widgets['layout'] << { widget: widget['id'] }

    update_obj(definition['id'], attribute => widgets)
  end
end