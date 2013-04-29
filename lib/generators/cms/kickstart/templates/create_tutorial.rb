class CreateTutorial < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= homepage_path %>")
    add_widget(homepage, '<%= main_content_attribute[:name] %>', {
      _obj_class: 'TextWidget',
      headline: 'Step 1: Your first widget.',
      content: '<p>This is a simple text widget, which is placed in the main content of your
        homepage. To add, edit or remove widgets, activate <strong>edit mode</strong> by clicking the pen in the
        upper right corner. <strong>Try it!</strong></p><div class="editing-content"><h3>Step 2:
        Playing with widgets.</h3><p>Yeah, congratulations! Now you can see the hovering, grey
        menu button in the left corner of the widget. Use it to add an <strong>Image widget</strong>
        !</p><h3>Step 3: Adding images.</h3><p>Alright, the image widget is still kind of boring.
        Lets drop in your favorite image and click on the text placeholder below to add a headline
        and a caption for the image.</p><h3>Step 4: Moving on.</h3><p>Do you see the
        <strong>Tutorial</strong> link in the main menu bar, right next to the company brand? Lets
        go there and continue the journey.</p></div>',
    })

    tutorial = Obj.find_by_path("<%= homepage_path %>/example-page")
    update_obj(tutorial.id, headline: 'Tutorial')
    add_widget(tutorial, '<%= main_content_attribute[:name] %>', {
      _obj_class: 'TextWidget',
      headline: 'Step 5: More content.',
      content: '<p>Glad you are still here. Do you notice the sidebar content to the right? It works
        exactly like the main content, so you can add more widgets, if you like.</p><h3>Step 6:
        Adding a new page.</h3><p>You probably already noticed the grey hovering menu button on
        the main navigation bar. You can use it to add a new page, a <strong>Page: Content</strong>
        for example, below the homepage. When you try it, then please come back to me to continue
        the tutorial.</p><h3>Step 7: </h3>',
    })
  end

  private

  def add_widget(obj, attribute, widget)
    widget.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget)

    widgets = obj.widgets(attribute)

    list = widgets.inject([]) do |values, widget|
      values << { widget: widget['id'] }
    end

    list << { widget: widget['id'] }

    update_obj(obj.id, attribute => { layout: list })

    puts "Created '#{widget['_obj_class']}'..."
  end
end