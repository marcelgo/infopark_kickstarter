class CreateTourExample < RailsConnector::Migration
  def resource_path
    '/resources/tour'
  end

  def tour_path
    "#{resource_path}/inline-editing"
  end

  def up
    create_obj(
      _path: resource_path,
      _obj_class: 'Container'
    )

    create_obj(
      _path: tour_path,
      _obj_class: '<%= tour_obj_class_name %>',
      headline: 'Inline Editing Tour'
    )

    # Step 1

    path = "#{tour_path}/step1"

    create_obj(
      _path: path,
      _obj_class: '<%= tour_step_obj_class_name %>',
      headline: 'Step 1: Inplace Editing GUI',
      sort_key: '1'
    )

    step = Obj.find_by_path(path)

    add_widget(step, 'content', {
      _obj_class: 'HeadlineWidget',
      headline: step.headline,
    })

    # Step 2

    path = "#{tour_path}/step2"

    create_obj(
      _path: path,
      _obj_class: '<%= tour_step_obj_class_name %>',
      headline: 'Step 2: Widget Basics',
      sort_key: '2'
    )

    step = Obj.find_by_path(path)

    add_widget(step, 'content', {
      _obj_class: 'HeadlineWidget',
      headline: step.headline,
    })

    # Step 3

    path = "#{tour_path}/step3"

    create_obj(
      _path: path,
      _obj_class: '<%= tour_step_obj_class_name %>',
      headline: 'Step 3: Working Copy',
      sort_key: '3'
    )

    step = Obj.find_by_path(path)

    add_widget(step, 'content', {
      _obj_class: 'HeadlineWidget',
      headline: step.headline,
    })

    # Example widget with tour trigger

    homepage = Obj.find_by_path("<%= example_cms_path %>")

    add_widget(homepage, "<%= example_widget_attribute %>", {
      _obj_class: 'TeaserWidget',
      headline: 'Welcome to Infopark',
      content: '<p>Lorem ipsum...</p>',
      link_to: [{
        title: 'Take the Tour',
        url: '/resources/tour/inline-editing/#tour',
      }],
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