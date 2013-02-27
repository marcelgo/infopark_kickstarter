class Box::BoxTextCell < BoxCell
  cache :show, if: proc {|cell, page, box| cell.session[:live_environment]} do |cell, page, box|
    [RailsConnector::Workspace.current.revision_id, box.id]
  end
end