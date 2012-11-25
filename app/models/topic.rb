class Topic < ActiveRecord::Base
  
  has_many :photos, :dependent => :destroy    
  attr_accessible :blurb, :body, :cover, :keywords, :name, :permalink, :state, :type, :uid 
  
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