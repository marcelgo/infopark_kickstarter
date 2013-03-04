class FlashMessagesCell < Cell::Rails
  def show(flash)
    @flash = flash

    render
  end

  def flash_message(type, class_name)
    @type = type
    @class_name = class_name

    render
  end
end