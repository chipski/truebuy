class ProductsController < InheritedResources::Base
  defaults :resource_class => Product, :collection_name => 'products', :instance_name => 'product'
  #respond_to :html, :json
  before_filter :authenticate_user!, :except => [:error, :show, :index]   
  
  def show
    resource
    @photos = resource.photos if resource
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: resource }
    end
  end
  
  def edit
    super do |format|
      format.html { render :edit }
      format.js { render :edit, :layout=>false }
    end
  end
  def create
    super do |format|
      format.html { 
        return_to = products_path
        redirect_to return_to, notice: "Product Created" 
      }
      format.js { head :no_content  }
    end
  end
  
  def rate_pop
    resource
    render :partial=>"products/rating_popup", :layout=>false 
  end

  def update
    resource
    resource.update_attributes!(product_params)
    redirect_to resource
  end  
    
  def update_state
    resource
    return_to = product_path(resource)
    resource = update_entity_state(@product, params[:state])
    respond_to do |format|
      if resource.save
        format.html { redirect_to return_to, notice: "State updated to #{params[:state]}" }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  protected
    def product_params
      params.permit(:active_date, :brand_id, :blurb, :body, :cover, :keywords, :name, :state, :category_ids, :model_num, :sku, :sku_type, :cached_tag_list)
    end
  
    def resource
      @product = Product.find_by_permalink(params[:id])
    end

end
