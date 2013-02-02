module ProductsHelper
  
  
  def rater_avatar(rateable_obj, rate, dimension=nil, options={})                             
 
    if dimension.nil?
      klass = rateable_obj.average
    else             
      klass = rateable_obj.average "#{dimension}"    
    end
    
    if klass.nil?
      avg = 0
    else
      avg = klass.avg
    end
    
    user = rate.rater
    user_ratings_num = user.ratings_given.count
    user_rating = rate.stars
    star = options[:star] || 5
    data_options = {"data-dimension" => dimension, :class => "rater_avatar", "data-rating" => user_rating, 
                    "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
                    "data-user_id" => user.id, "data-user_ratings_num" =>user_ratings_num,
                    "data-star-count" => star,
                    "href" => user_path(user)
                    }
    
    content_tag :a, data_options do
      content_tag(:img, "", "src"=>user.avatar_url, :class=>"avatar_img") +
      content_tag(:div, user_rating, :class=>"metric") +
      content_tag(:div, user.name, :class=>"rater_name") 
      
    end            
  end

end
