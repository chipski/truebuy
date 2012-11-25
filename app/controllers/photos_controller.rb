class PhotosController < InheritedResources::Base
  defaults :resource_class => Photo, :collection_name => 'photos', :instance_name => 'photo'
  respond_to :html, :json   
  

  def index
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]  
    @photos = @topic ? @topic.photos : Photo.all
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
  def show
    @photo = Photo.find(params[:id])
    puts "Photo.show got #{@photo}"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end
  
  def new
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]
    @photo = @topic ? @topic.photos.build : Photo.create

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end
  def edit
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]   
    @photo = @topic ? @topic.photos.find(params[:id]) : Photo.find(params[:id]) 
    # @photo = Picture.find(params[:id])
  end
  
  def create
    p_attr = params[:photo]
    p_attr[:image] = params[:photo][:image].first if params[:photo][:image].class == Array

    @topic = Topic.find(params[:topic_id])
    @photo = @topic.photos.build(p_attr)
    
    if @photo.save
      respond_to do |format|
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@photo.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end
  def update
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]
    @photo = @topic ? @topic.photos.find(params[:id]) : Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @topic ? @topic : @photo , notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end
  def make_default
    @photo = Photo.find(params[:photo_id])
    @topic = Topic.find(params[:topic_id])

    @topic.cover = @photo.id
    @topic.save

    respond_to do |format|
      format.js
    end
  end

  protected
      def collection
        @photos ||= end_of_association_chain.paginate(:page => params[:page])
      end 
      def begin_of_association_chain
        @current_user
      end
end
