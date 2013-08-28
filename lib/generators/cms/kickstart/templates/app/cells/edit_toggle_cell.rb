class EditToggleCell < Cell::Rails
  # Cell actions:

  def show
    if EditModeDetection.editing_allowed?(session)
      @current_workspace = RailsConnector::Workspace.current.title
      render
    end
  end
end