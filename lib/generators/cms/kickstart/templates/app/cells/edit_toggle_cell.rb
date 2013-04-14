class EditToggleCell < Cell::Rails
  # Cell actions:

  def show
    if EditModeDetection.editing_allowed?(session)
      render
    end
  end
end