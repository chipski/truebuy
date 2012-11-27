class Category < ActiveRecord::Base
  
  has_one :photo
  
  attr_accessible :blurb, :body, :keywords, :name, :permalink, :state, :type, :uid
  
  after_save :update_permalink    
  
  
  def update_permalink
    UtilityIds.update_permalink(self, self.name)   
  end
  
end
