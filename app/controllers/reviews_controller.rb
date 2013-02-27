class ReviewsController < InheritedResources::Base
  
  def new
    @product = Product.find(params[:p]) if params[:p]
  end
  
  def new_modal
    @review = Review.new
    @product = Product.find(params[:p]) if params[:p]
    render :partial=>"reviews/form", :layout=>"popups"
  end
  
end
