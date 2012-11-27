class PhotosController < InheritedResources::Base
  defaults :resource_class => Photo, :collection_name => 'photos', :instance_name => 'photo'
  respond_to :html, :json   
  

  def index
    @topic = Topic.find(params[:topic_id]) if params[:topic_id]  
    @photos = @topic ? @topic.photos : Photo.all
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos.collect { |p| p.to_jq_upload }.to_json }
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
    Rails.logger.info("Photo.create p_attr=#{p_attr} topic=#{params[:topic_id]} company=#{params[:company_id]}")
    if params[:topic_id]
      @parent = Topic.find(params[:topic_id])
      @photo = @parent.photos.build(p_attr) 
    elsif params[:company_id]  
      @parent = Company.find(params[:company_id])
      @photo = Photo.create(p_attr)
      @parent.update_attribute(:photo_id, @photo.id)
    end 
    
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
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @photo = @topic.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to topic_photos_url }
      format.json { render :json => true }
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


end
