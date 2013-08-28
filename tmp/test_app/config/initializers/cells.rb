unless Rails.env.development?
  Cell::Rendering::ClassMethods.class_eval do
    def render_cell_for(name, state, *args)
      cell = nil
      cell = create_cell_for(name, *args)

      yield cell if block_given?

      render_cell_state(cell, state, *args)
    rescue => exception
      if cell
        parent = cell.parent_controller

        until parent.is_a?(ActionController::Base)
          parent = parent.parent_controller
        end

        if defined?(Airbrake)
          parent.send(:notify_airbrake, exception)
        end

        if defined?(Honeybadger)
          parent.send(:notify_honeybadger, exception)
        end
      else
        if defined?(Airbrake)
          Airbrake.notify(exception)
        end

        if defined?(Honeybadger)
          Honeybadger.notify(exception)
        end
      end

      ''
    end
  end
end