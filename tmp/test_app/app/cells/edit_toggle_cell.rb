class EditToggleCell < Cell::Rails
  include Authentication

  # Cell actions:

  def show
    if EditModeDetection.editing_allowed?(session)
      @workspace_title = RailsConnector::Workspace.current.title || I18n.t('editing.published_workspace_title')

      render
    end
  end
end
