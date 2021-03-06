class BrandsController < InheritedResources::Base
  defaults :resource_class => Brand, :collection_name => 'brands', :instance_name => 'brand'
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  
  
  def show
    resource
    @search ||= ProductSearch.new
    @products = @search.query([resource.id])
    @products = resource.products if @products.length < 1
  end
  
  def edit
    super do |format|
      format.html { render :edit }
      format.js { render :edit, :layout=>false }
    end
  end
  
  def update
    resource
    resource.update_attributes!(brand_params)
    redirect_to resource
  end
  
  def update_state
    resource
    return_to = brand_path(resource)
    resource = update_entity_state(@brand, params[:state])
    respond_to do |format|
      if @brand.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
    def brand_params
      params.permit(:blurb, :body, :cached_tag_list, :cover, :keywords, :name, :permalink, :state, :category_ids, :company_id)
    end
    
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
