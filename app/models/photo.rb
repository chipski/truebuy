class Photo < ActiveRecord::Base
  
  
  attr_accessible :blurb, :image_name, :image_uid, :keywords, :name, :permalink, :state, :type, :uid   
  
  
end
