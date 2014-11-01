class TopicsController < InheritedResources::Base
  defaults :resource_class => Topic, :collection_name => 'topics', :instance_name => 'topic'
  respond_to :html, :json, :js
  custom_actions :resource => [:content, :admin], :collection => :search
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]   
  
  def show
    resource
    @photos = @topic.photos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end
  
  def edit
    super do |format|
      format.html { render :edit }
      format.js { render :edit, :layout=>false }
    end
  end

  def update
    resource
    resource.update_attributes!(topic_params)
    redirect_to resource
  end  
      
  def update_state
    resource
    return_to = resource_url
    resource = update_entity_state(@topic, params[:state])
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
    def topic_params
      params.permit(:blurb, :body, :cover, :keywords, :name, :permalink, :state, :category_ids, :company_id, :brand_id, :slide_order)
    end
  
    def resource
      @topic = Topic.find_by_permalink(params[:id])
    end
    def collectionOff
      @topics ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    def begin_of_association_chainOFF
      @current_user
    end
  
end
