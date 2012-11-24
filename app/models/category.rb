class Category < ActiveRecord::Base
  
  has_one :photo
  
  attr_accessible :blurb, :body, :keywords, :name, :permalink, :state, :type, :uid

end
