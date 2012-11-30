module PhotosHelper
  
  def parent_photo_path(photo, parent, action="")
    route_path = "#{action ? action+'_' : '' }photo_path"
    route_path(photo, :parent_type=>parent.class, :parent_id=>parent.id)  
  end
end
