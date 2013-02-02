class Brand < ActiveRecord::Base
  belongs_to :company
  has_many :topics 
  has_many :products 
  has_and_belongs_to_many :categories, :class_name => "Category"  
  has_many :photos, :as => :parent, :class_name => "Photo"     
  
  attr_accessible :blurb, :body, :cached_tag_list, :cover, :keywords, :name, :permalink, :state, :category_ids, :company_id
  
  before_save :update_permalink   
  #after_save :update_order   

  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  def update_order(children_names=["photos","topics"])
    UtilityIds.update_order(self, children_names) 
  end

    
  default_scope order(:slide_order) 
  #scope :active_for, lambda {|current_user| where(:state=>:active)}     
  #scope :initial, where(:state=>["new","", nil])
  scope :not_active, where(:state=>["new","review", "inactive","error", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def products_filtered(filter={})
    self.products.where({}).all
  end
  
  # State machine, should be shared in mixin but error now
  include AASM 
  #include LifeCycleState
  aasm :column => :state do
    state :new,      :initial => true              
    state :review,   :enter => :make_review 
    state :launch,   :enter => :make_launch 
    state :active,   :enter => :make_active
    state :inactive, :enter => :make_inactive
    state :error,    :enter => :make_inactive  
    state :list_only,:enter => :make_list_only
     
    event :mark_review do
      transitions :to => :review
    end
    event :mark_launch do
      transitions :to => :launch 
    end
    event :mark_active do
      transitions :to => :active 
    end
    event :mark_inactive do
      transitions :to => :inactive 
    end  
    event :mark_error do
      transitions :to => :error 
    end
    event :mark_list_only do
      transitions :to => :list_only 
    end
    event :mark_admin_only do
      transitions :to => :new #, :from => :all
    end
  end
  def make_review
    #self.children.map{|c| c.mark_review!}
  end
  def make_launch
    #self.children.map{|c| c.mark_launch!}
  end
  def make_active
    #self.children.map{|c| c.mark_active!}
  end
  def make_inactive
    #self.children.map{|c| c.mark_inactive!}  
  end 
  def make_list_only
    #self.children.map{|c| c.mark_list_only!}
  end
  
  
  def slider_photos
    (self.photos.order(:slide_order) + self.topics.collect{|t| t.photos.order(:slide_order)}).flatten
  end
  
  
  def cover_url(size="small")
    @cover_url ||= begin
      UtilityIds.cover_url(self, size="small")
    end
    @cover_url ? @cover_url : "default/high_server.jpeg"
  end
  
  def to_partial_path() 
    "brands/grid_cell" 
  end
  
  def to_s
    name
  end
  def to_param
    permalink
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