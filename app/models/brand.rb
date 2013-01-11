class Brand < ActiveRecord::Base
  belongs_to :company
  has_many :topics 
  has_many :products 
  has_and_belongs_to_many :categories, :class_name => "Category"  
  has_many :photos, :as => :parent, :class_name => "Photo"     
  
  attr_accessible :blurb, :body, :cached_tag_list, :cover, :keywords, :name, :permalink, :state, :category_ids, :company_id
  
  after_save :update_permalink  
  after_save :update_order   
    
  default_scope order(:slide_order) 
  #scope :active, lambda {|current_user| where(:state=>:active)}     
  #scope :initial, where(:state=>["new","", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def products_filtered(filter={})
    self.products.where({}).all
  end
  
  def slider_photos
    (self.photos + self.topics.collect{|t| t.photos}).flatten
  end
  
  
  def cover_url(size="small")
    @cover_url ||= begin
      UtilityIds.cover_url(self, size="small")
    end
    @cover_url ? @cover_url : "default/high_server.jpeg"
  end
  
  def to_param
    permalink
  end
  
  def update_order(children_names=["photos","topics"])
    UtilityIds.update_order(self, children_names) 
  end
  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  
end

#create_table "brands", :force => true do |t|
#  t.integer  "company_id"
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.text     "body"
#  t.string   "state",           :default => "new"
#  t.string   "type"
#  t.integer  "cover"
#  t.integer  "slide_order",     :default => 0
#  t.string   "cached_tag_list"
#  t.datetime "created_at",                         :null => false
#  t.datetime "updated_at",                         :null => false
#end