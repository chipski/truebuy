class ReviewsController < InheritedResources::Base
  defaults :resource_class => Review, :collection_name => 'reviews', :instance_name => 'review'
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  

  def show
    resource
    @product = resource.product if resource
    respond_to do |format|
      format.html { render "products/show"}
      format.json { render json: resource }
    end
  end

  def new
    @product = Product.find(params[:p]) if params[:p]
  end
  
  def new_modal
    @review = Review.new
    @product = Product.find(params[:p]) if params[:p]
    render :partial=>"reviews/form", :layout=>"popups"
  end
  
  def create
    super do |format|
      format.html { 
        return_to = @review.product ? product_path(@review.product) : @review
        redirect_to return_to, notice: "Review Created" 
      }
      format.js { head :no_content  }
    end
  end
  
  protected
    def resource
      @review = Review.find_by_permalink(params[:id])
    end
    def collection
      @reviews ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    
end
