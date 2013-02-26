class Box::BoxGoogleMapsCell < BoxCell
  def show(page, box)
    @id = "map_canvas_#{box.id}"
    @url = google_map_path(box, dom_identifier: @id, format: :json)

    super
  end
end