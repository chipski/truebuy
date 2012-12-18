class Category < ActiveRecord::Base
  belongs_to :parent
  has_many :photos, :as => :parent, :class_name => "Photo" 
  has_and_belongs_to_many :topics, :class_name => "Topic"   
  has_and_belongs_to_many :brands, :class_name => "Brand" 
  has_and_belongs_to_many :companies, :class_name => "Company" 
  
  attr_accessible :blurb, :body, :cached_tag_list, :cover, :keywords, :name, :permalink, :state, :type, :parent_id
  
  after_save :update_permalink    
  default_scope order(:slide_order) 
  #scope :active, lambda {|current_user| where(:state=>:active)}     
  #scope :initial, where(:state=>["new","", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def cover_url(size="small")
    @cover_url ||= begin
      UtilityIds.cover_url(self, size="small")
    end
    @cover_url ? @cover_url : "default/high_stride.jpeg"
  end

  def to_param
    permalink
  end
  
  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  
end

#create_table "categories", :force => true do |t|
#  t.integer  "parent_id"
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.text     "body"
#  t.string   "state",           :default => "new"
#  t.string   "type"
#  t.integer  "cover"
#  t.string   "cached_tag_list"
#  t.datetime "created_at",                         :null => false
#  t.datetime "updated_at",                         :null => false
#end