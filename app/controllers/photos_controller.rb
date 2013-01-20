class PhotosController < InheritedResources::Base
  defaults :resource_class => Photo, :collection_name => 'photos', :instance_name => 'photo'
  respond_to :html, :json   
  
  before_filter :authenticate_user!, :except => [:error, :show, :index]  

  def index
    @photos = @parent ? @parent.photos : Photo.all
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
    @photo = @parent ? @parent.photos.build : Photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end
  def edit
    @photo = @parent ? @parent.photos.find(params[:id]) : Photo.find(params[:id]) 
    # @photo = Picture.find(params[:id])
  end
  
  def create
    p_attr = params[:photo]
    p_attr[:image] = params[:photo][:image].first if params[:photo][:image].class == Array
    Rails.logger.info("Photo.create p_attr=#{p_attr} parent=#{params[:parent_id]} company=#{params[:company_id]}")
    @photo = @parent ? @parent.photos.build(p_attr) : Photo.create(p_attr)

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
    @photo = @parent ? @parent.photos.find(params[:id]) : Photo.find(params[:id])
    p_attr = params[:photo]
    p_attr[:image] = params[:photo][:image].first if params[:photo][:image].class == Array
    return_to = params[:return_to] || (@parent ? resource_path(@parent) : resource_path(resource))
    respond_to do |format|
      if @photo.update_attributes(p_attr)
        format.html { redirect_to return_to , notice: 'Picture was successfully updated.' }
        format.json { render :json => [@photo.to_jq_upload].to_json }
      else
        format.html { render action: "edit" }
        format.json { 
          Rails.logger.info("Photo.update errors=#{@photo.errors.inspect}")
          render json: @photo.errors.to_json, status: :unprocessable_entity 
        }
      end
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    return_to = params[:return_to] || @photo.parent ? polymorphic_path(@photo.parent, :action=>:edit) : nil
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to (return_to || photos_url) }
      format.json { render :json => true }
    end
  end
  
  def make_default
    @photo = Photo.find(params[:photo_id])
    klass_name = params[:parent_type]
    @parent = klass_name.constantize.find(params[:parent_id])

    @parent.cover = @photo.id
    @parent.save

    respond_to do |format|
      format.js
    end
  end
  
  def update_state
    resource
    return_to = resource_path(resource)
    update_entity_state(@resource, params[:state])
    respond_to do |format|
      if resource.save
        format.html { redirect_to return_to }
        format.json { head :no_content }
      else
        format.html { redirect_to return_to, notice: "Cannot update the state" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
    def collection
      @photos ||= end_of_association_chain.paginate(:page => params[:page])
    end 
    def begin_of_association_chain                         
      if params[:parent_id] && params[:parent_type] 
        parent_klass = begin
          case params[:parent_type]
          when "Company" 
            Company
          when "Brand"
            Brand
          when "Category"
            Category
          when "Topic"
            Topic
          else
            Topic
          end 
        end 
        @parent = parent_klass.find(params[:parent_id])
      elsif params[:category_id]
        @parent = Category.find(params[:category_id])
      elsif params[:company_id]
        @parent = Company.find(params[:company_id])
      elsif params[:topic_id]
        @parent = Topic.find(params[:topic_id])
      end
    end   

end
