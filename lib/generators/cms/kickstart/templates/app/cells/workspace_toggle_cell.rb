class WorkspaceToggleCell < Cell::Rails
  def show
    @workspaces = RailsConnector::CmsRestApi.get('workspaces')['results']

    if EditModeDetection.editing_allowed?(session)
      render
    end
  end

  def content
    @current_workspace = get_current_workspace(@workspaces)

    if @workspaces.size > 1
      render(view: 'workspaces')
    else
      render(view: 'workspace')
    end
  end

  private

  def get_current_workspace(workspaces)
    workspaces.detect do |workspace|
      workspace['id'] == RailsConnector::Workspace.current.id
    end
  end
end