class Box::BoxGalleryCell < BoxCell
  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def show(page, box)
    @id = "gallery_#{box.id}"
    @images = box.gallery_images
    super
  end
end