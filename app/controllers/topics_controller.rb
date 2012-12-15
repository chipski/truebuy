class TopicsController < InheritedResources::Base
  defaults :resource_class => Topic, :collection_name => 'topics', :instance_name => 'topic'
  #respond_to :html, :json
  
  def show
    @topic = Topic.find(params[:id])
    @company = @topic.company || Company.find(params[:id])
    @photos = @topic.photos
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end
  
  def update_state
    @topic = Topic.find(params[:id])
    return_to = topic_path(@topic)
    update_entity_state(@topic, params[:state])
    respond_to do |format|
      if @topic.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end  
  
  protected
    def collectionOff
      @topics ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    def begin_of_association_chainOFF
      @current_user
    end
  
end
