class TopicsController < InheritedResources::Base
  
  def show
    @topic = Topic.find(params[:id])
    @photo = @topic.photos.build
    @photos = Photo.find(:all, :conditions  => [ 'topic_id = ?', @topic.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end
  
  
end
