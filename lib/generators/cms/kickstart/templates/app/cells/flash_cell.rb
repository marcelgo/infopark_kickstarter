class FlashCell < Cell::Rails
  # Cell actions:

  def messages(flash)
    @flash = flash
    @types = types.keys

    render
  end

  # Cell states:
  # The following states assume @flash to be given.

  def message(type)
    @type = type
    @class_name = types[type]

    if @flash[type]
      render
    end
  end

  private

  # Defines mapping between flash type and its HTML class name.
  def types
    {
      alert: 'alert-error',
      notice: 'alert-success',
      warning: 'alert-warning',
      info: 'alert-info',
    }
  end
end