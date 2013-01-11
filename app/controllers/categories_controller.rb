class CategoriesController < InheritedResources::Base
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  
  
  def update_state
    resource
    return_to = category_path(@category)
    update_entity_state(@category, params[:state])
    respond_to do |format|
      if @category.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
    def resource
      @category = Category.find_by_permalink(params[:id])
      @search = ProductSearch.new
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
