class ProductsController < InheritedResources::Base
  defaults :resource_class => Product, :collection_name => 'products', :instance_name => 'product'
  #respond_to :html, :json
  before_filter :authenticate_user!, :except => [:error, :show, :index]   
  
  def show
    resource
    @photos = resource.photos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: resource }
    end
  end
  
  def edit
    super do |format|
      format.html { render :show }
      format.js { render :edit, :layout=>false }
    end
  end
  
  def update_state
    resource
    return_to = product_path(resource)
    update_entity_state(@resource, params[:state])
    respond_to do |format|
      if resource.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  protected
    def resource
      @product = Product.find_by_permalink(params[:id])
    end

end