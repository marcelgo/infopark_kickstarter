class Box::BoxImageCell < BoxCell
  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def image(source, link_to)
    return if source.blank?

    if link_to.present?
      render(view: 'image_with_link', locals: { source: source, link_to: link_to })
    else
      render(view: 'image_without_link', locals: { source: source })
    end
  end
end