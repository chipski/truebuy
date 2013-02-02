class Store < ActiveRecord::Base
  has_many :locations
  
  attr_accessible :blurb, :keywords, :name, :permalink, :realtime_availability, :state, :store_id, :type, :uid, :url, :url2
  


end


#create_table "stores", :force => true do |t|
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.string   "state"
#  t.string   "type"
#  t.string   "url"
#  t.string   "url2"
#  t.string   "store_id"
#  t.boolean  "realtime_availability"
#  t.datetime "created_at",            :null => false
#  t.datetime "updated_at",            :null => false
#end
#