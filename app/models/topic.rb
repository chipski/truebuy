class Topic < ActiveRecord::Base
  belongs_to :company
  has_many :photos, :dependent => :destroy    
  attr_accessible :blurb, :body, :cover, :keywords, :name, :permalink, :state, :type, :company_id 
  
  #after_save :update_permalink    
  
  default_scope order(:updated_at) 
  #scope :active, lambda {|current_user| where(:state=>:active)}     
  #scope :inactive, lambda {|current_user| where(:state=>[:inactive])}      
  #scope :initial, where(:state=>["new","", nil])
  
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  
end

#create_table "topics", :force => true do |t|
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"              
# t.integer  "company_id"
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