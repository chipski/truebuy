class TopicsController < InheritedResources::Base
  defaults :resource_class => Topic, :collection_name => 'topics', :instance_name => 'topic'
  #respond_to :html, :json
  
  def show
    @topic = Topic.find(params[:id])
    @photos = Photo.find(:all, :conditions  => [ 'topic_id = ?', @topic.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
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
