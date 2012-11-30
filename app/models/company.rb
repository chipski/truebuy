class Company < ActiveRecord::Base
  
  has_many :photos, :as => :parent, :class_name => "Photo"
     
  has_many :topics  
  attr_accessible :blurb, :body, :cover, :duns, :keywords, :name, :permalink, :state, :type, :photo_id, :url, :url2      
   
  after_save :update_permalink  
  
  default_scope order(:updated_at) 
  scope :active, lambda {|current_user| where(:state=>:active)}     
  scope :inactive, lambda {|current_user| where(:state=>[:inactive])}      
  scope :initial, where(:state=>[:new, nil])
  
  def self.select_active
    self.initial.collect{ |t| [" #{t.name[0..30]}", t.id]}
  end
  
  def cover_url
    if cover
      Photo.find_by_id(cover).image.thumb.url
    else
      "default/sky_hang.jpeg"
    end
  end
  
  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  
end
  
#create_table "companies", :force => true do |t|
#  t.integer  "photo_id"
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.text     "body"
#  t.string   "state"
#  t.string   "type"
#  t.string   "duns"
#  t.string   "url"
#  t.string   "url2"
#  t.integer  "cover"
#  t.datetime "created_at", :null => false
#  t.datetime "updated_at", :null => false
#end