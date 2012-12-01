module ApplicationHelper                      
  
  
  def title(page_title)
    content_for(:title) { page_title }
  end
   
   def parent_photo_path(photo, parent)
     if photo.id
       photo_path(photo.id, :parent_type=>parent.class.to_s, :parent_id=>parent.id) 
     else
       photos_path(:parent_type=>parent.class.to_s, :parent_id=>parent.id, :method=>:post)  
     end 
   end
    
end
