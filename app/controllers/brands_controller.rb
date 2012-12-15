class BrandsController < InheritedResources::Base
  defaults :resource_class => Brand, :collection_name => 'brands', :instance_name => 'brand'
  
  def update_state
    @brand = Brand.find(params[:id])
    return_to = brand_path(@brand)
    update_entity_state(@brand, params[:state])
    respond_to do |format|
      if @brand.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
