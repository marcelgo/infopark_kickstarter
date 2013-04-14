class WorkspaceToggleCell < Cell::Rails
  # Cell actions:

  def show
    @workspaces = RailsConnector::CmsRestApi.get('workspaces')['results']

    if EditModeDetection.editing_allowed?(session)
      render
    end
  end

  def content
    @current_workspace = @workspaces.detect do |workspace|
      workspace['id'] == RailsConnector::Workspace.current.id
    end

    if @workspaces.size > 1
      render(view: 'workspaces')
    else
      render(view: 'workspace')
    end
  end

  # Cell states:

  def title(workspace)
    @workspace = workspace

    render
  end
end