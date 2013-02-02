class LocationsController < InheritedResources::Base
  
  
  def update_location
    resource
    return_to = resource_url
    resource = resource.from_location(request.location)
    respond_to do |format|
      if resource.save
        format.html { redirect_to return_to }
        format.js { render :show, :layout=>false }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
    def resourceOFF
      #@location = Location.find_by_permalink(params[:id])
      @location = Location.find(params[:id])
    end
end
