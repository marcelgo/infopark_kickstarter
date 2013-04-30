class CreateTutorial < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= homepage_path %>")
    add_widget(homepage, '<%= main_content_attribute[:name] %>', {
      _obj_class: 'TextWidget',
      content: '<div class="hero-unit"><h1>Welcome to Infopark.</h1><p>You successfully started your
        project. We created some example content for you and extended the Ruby on Rails application
        a bit, so you have something to start with. You are probably asking yourself, what can I do
        now, where does all that come from and how does it work? Don\'t worry, you can find extensive
        help and support in the Infopark Dev Center. We recommend to start there and also get
        comfortable with your Ruby on Rails Application.</p><p>
        <a href="https://dev.infopark.net/preparation">Explore your platform</a></p></div>',
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    widget_params.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget_params)

    widgets = obj.widgets(attribute)

    list = widgets.inject([]) do |values, widget|
      values << { widget: widget['id'] }
    end

    list << { widget: widget['id'] }

    update_obj(obj.id, attribute => { layout: list })
  end
end
