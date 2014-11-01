class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  before_save :update_permalink   
  
  #default_scope order(:slide_order) 
  scope :active_all, where(:state=>["active"])
  scope :not_active, where(:state=>["new","review", "inactive","error", nil]).group(:product_id)
  #scope :initial, where(:state=>["new","", nil])
  
  
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
    # make all children campaigns for make_launch
    #self.children.map{|c| c.mark_launch!}
  end
  def make_active
    # propogate down to children   
    #Rails.logger.info("Campaign.make_active for child campaigns #{self.children.size}")     
    #self.children.map{|c| c.mark_active!}
  end
  def make_inactive
    # propogate down to children 
    #Rails.logger.info("Campaign.make_inactive for child campaigns #{self.children.size}")     
    #self.children.map{|c| c.mark_inactive!}  
  end 
  def make_list_only
    # propogate down to children 
    #self.children.map{|c| c.mark_list_only!}
    # propogate to sf  
  end

  def to_partial_path
    "reviews/grid_cell" 
  end
  def to_param
    permalink
  end
  def update_permalink
    # ensure name has a value
    self.name = self.name || "#{self.product} "
    UtilityIds.update_permalink(self, self.name) 
  end

end

#create_table "reviews", :force => true do |t|
#    t.integer  "product_id"
#    t.integer  "user_id"
#    t.string   "uid"
#    t.string   "permalink"
#    t.string   "name"
#    t.string   "keywords"
#    t.text     "blurb"
#    t.text     "body"
#    t.string   "state",            :default => "new"
#    t.string   "type"
#    t.date     "active_date"
#    t.date     "deactivated_date"
#    t.integer  "slide_order",      :default => 0
#    t.string   "cached_tag_list"
#    t.datetime "created_at",                          :null => false
#    t.datetime "updated_at",                          :null => false
#  end