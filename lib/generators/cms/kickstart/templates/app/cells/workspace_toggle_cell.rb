class WorkspaceToggleCell < Cell::Rails
  def show
    @workspaces = RailsConnector::CmsRestApi.get('workspaces')['results']

    render
  end

  def content
    @current_workspace = get_current_workspace(@workspaces)

    if @workspaces.size > 1
      set_titles!(@workspaces)

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

  def set_titles!(workspaces)
    workspaces.each do |workspace|
      workspace['title'] ||= 'Published'
    end
  end
end