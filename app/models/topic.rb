class Topic < ActiveRecord::Base
  belongs_to :company
  belongs_to :brand
  has_and_belongs_to_many :categories, :class_name => "Category"  
  has_many :photos, :as => :parent, :class_name => "Photo"  
  attr_accessible :blurb, :body, :cover, :keywords, :name, :permalink, :state, :category_ids, :company_id, :brand_id
  
  after_save :update_permalink   
  #after_save :update_order   
   
  #default_scope order(:slide_order) 
  scope :active_for, lambda {|current_user| where(:state=>:active)}     
  scope :active_all, where(:state=>[:active])
  #scope :initial, where(:state=>["new","", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
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
      transitions :to => :launch #, :from => [:review, :inactive, :active, :list_only, :error]
    end
    event :mark_active do
      transitions :to => :active #, :from => [:review, :inactive, :active, :list_only, :error]
    end
    event :mark_inactive do
      transitions :to => :inactive #, :from => [:active, :new, :inactive, :list_only, :error]
    end  
    event :mark_error do
      transitions :to => :error #, :from => [:active, :new, :inactive, :list_only, :error]
    end
    event :mark_list_only do
      transitions :to => :list_only #, :from => [:active, :new, :inactive, :list_only, :error]
    end
    event :mark_admin_only do
      transitions :to => :new #, :from => :all
    end
  end
  def make_review
    # make all children campaigns for review
    #self.children.map{|c| c.mark_review!}
  end
  def make_launch
    #self.children.map{|c| c.mark_launch!}
  end
  def make_active
    #self.children.map{|c| c.mark_active!}
  end
  def make_inactive
    # propogate down to children 
    #Rails.logger.info("Topic.make_inactive for child topics #{self.children.size}")     
    #self.children.map{|c| c.mark_inactive!}  
  end 
  def make_list_only
    # propogate down to children 
    #self.children.map{|c| c.mark_list_only!}
  end
  def delete_children
    #self.children.map{|c| c.delete_children}
  end
  
  def slider_photos
    self.cover ? (self.photos - [Photo.find(self.cover)]) : self.photos
  end
  
  def cover_url(size="small")
    @cover_url ||= begin
      UtilityIds.cover_url(self, size="small")
    end
    @cover_url ? @cover_url : "NoImageAvailable.jpg"
  end
  
  def to_partial_path() 
    "topics/grid_cell" 
  end
  
  def to_param
    permalink
  end
  
  def update_order(children_names=["photos"])
    UtilityIds.update_order(self, children_names) 
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
# t.integer  "brand_id"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.text     "body"
#  t.string   "state"
#  t.string   "type"
#  t.string   "cover"
# t.integer  "slide_order",     :default => 0
#  t.datetime "created_at", :null => false
#  t.datetime "updated_at", :null => false
#end
#  