module TopicsHelper
  
  def parent_path(photo, parent, action="")
    if action
      route_path = "#{action}_topic_path"
    else
      route_path = "topics_path"
    end
    route_path(photo, :parent_type=>parent.class, :parent_id=>parent.id)  
  end
end
