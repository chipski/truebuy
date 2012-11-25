class Topic < ActiveRecord::Base
  
  has_many :photos, :dependent => :destroy    
  attr_accessible :blurb, :body, :cover, :keywords, :name, :permalink, :state, :type, :uid 
  
  after_save :update_permalink    
  
  
  def update_permalink
    secret = "#{self.name}".gsub(" ", "_")  # add random
    permalink = Digest::SHA2.hexdigest(secret)
    token = Digest::SHA1.hexdigest(secret)
    if self.permalink != permalink
      self.update_attribute(:permalink, permalink)
      self.update_attribute(:uid, token)
    end      
  end
  
end

#create_table "topics", :force => true do |t|
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.text     "body"
#  t.string   "state"
#  t.string   "type"
#  t.string   "cover"
#  t.datetime "created_at", :null => false
#  t.datetime "updated_at", :null => false
#end
#