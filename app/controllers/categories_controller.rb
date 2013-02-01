class CategoriesController < InheritedResources::Base
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  
  
  def index
    #@search ||= ProductSearch.new
    #@products = @search.query()
  end

  def show
    resource
    @search ||= ProductSearch.new
    @products = @search.query([resource.id])
  end

  
  def edit
    super do |format|
      format.html { render :edit }
      format.js { render :edit, :layout=>false }
    end
  end
  
  def content
    resource
    collection = resource.products 
    @brands = resource.brands
    respond_to do |format|
      format.html { render :partial=>"shared/content" }
      format.js { render :partial=>"shared/content" }
    end
  end
  
  
  def update_state
    resource
    return_to = collection_path #category_path(@category)
    resource = update_entity_state(@category, params[:state])
    respond_to do |format|
      if @category.save
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
      @category = Category.find_by_permalink(params[:id])
    end
    def collection
      @categories ||= begin
        if params[:category_ids] 
          Category.filter_by_ids(params[:category_ids], params[:page])
        else
          end_of_association_chain.paginate(:page => params[:page])
        end
      end
    end 
    def begin_of_association_chainOff
      
      if params[:category_ids] && false
        @categories = Category.filter_by_ids(params[:category_ids])
      else
        @categories = Category.all
      end
    end
    
end
