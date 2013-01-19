class BrandsController < InheritedResources::Base
  defaults :resource_class => Brand, :collection_name => 'brands', :instance_name => 'brand'
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  
  
  
  def edit
    super do |format|
      format.html { render :show }
      format.js { render :edit, :layout=>false }
    end
  end
  
  def update_state
    resource
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
  
  protected
    def resource
      @brand = Brand.find_by_permalink(params[:id])
    end
    def collectionOff
      @brands ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    def begin_of_association_chainOFF
      @current_user
    end
    
end
