class Category < ActiveRecord::Base
  
  has_one :photo
  
  attr_accessible :blurb, :body, :keywords, :name, :permalink, :state, :type, :uid
  
  after_save :update_permalink    
  
  
  def update_permalink
    permalink = "#{self.name}_#{self.id}".gsub(" ", "_")  # add random
    #permalink = Digest::SHA2.hexdigest(secret)
    token = Digest::SHA1.hexdigest(permalink)
    if self.permalink != permalink
      self.update_attribute(:permalink, permalink)
      self.update_attribute(:uid, token)
    end      
  end
  
end
