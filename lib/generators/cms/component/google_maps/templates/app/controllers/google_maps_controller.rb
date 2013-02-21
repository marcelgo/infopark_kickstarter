class GoogleMapsController < CmsController
  def show
    @google_maps = BoxGoogleMaps.find(params[:id])
    @google_maps.dom_identifier = params[:dom_identifier]

    respond_to do |format|
      format.json { render :json => @google_maps }
    end
  end
end