class CreateTextWidgetExample < ::RailsConnector::Migration
  def up
    text_widget = create_obj(
      _path: "_widgets/#{homepage.id}/#{SecureRandom.hex(8)}",
      _obj_class: 'TextWidget',
      title: 'TextWidget',
      body: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    )

    widgets = main_content.inject([]) do |values, widget|
      values << {widget: widget['id']}
    end

    widgets << {widget: text_widget['id']}

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
     Obj.find_by_path("/website/en")
  end
end