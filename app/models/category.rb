class Category < ActiveRecord::Base
  belongs_to :parent
  has_many :photos, :as => :parent, :class_name => "Photo" 
  has_and_belongs_to_many :topics, :class_name => "Topic"   
  has_and_belongs_to_many :brands, :class_name => "Brand" 
  has_and_belongs_to_many :companies, :class_name => "Company" 
  has_and_belongs_to_many :products, :class_name => "Product" 
  
  before_save :update_permalink   
  #after_save :update_order   

  def update_permalink
    UtilityIds.update_permalink(self, self.name) 
  end
  def update_order(children_names=["photos"])
    UtilityIds.update_order(self, children_names) 
  end

  #default_scope order(:slide_order) 
  #scope :active, lambda {|current_user| where(:state=>:active)}     
  #scope :initial, where(:state=>["new","", nil])
  scope :not_active, where(:state=>["new","review", "inactive","error", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def self.filter_by_ids(category_ids=nil, page=nil)
    #category_ids = category_ids.to_a
    if category_ids
      if category_ids.is_a?(Array)
        Category.find(category_ids)
      else
        Category.paginate(:page => page).all
      end
    else
      Rails.logger.info("Category.filter_by_ids no categories found for category_ids=#{category_ids}")
      Category.paginate(:page => page).all
    end
  end
  
  def self.products_filtered(brand_ids="all", category_ids="all")
    categories = Category.filter_by_ids(category_ids)
    products = categories.map{|c| c.products_filtered(brand_ids)}.flatten
    Rails.logger.info("Category.products_filtered found #{products.size} products ")
    products
  end

  def products_filtered(brand_ids=nil)
    if brand_ids
      if brand_ids.is_a?(Array)
        self.products.where({:brand_id => brand_ids}).all
      else
        Rails.logger.info("category.products_filtered no products found for brand_ids=#{brand_ids}")
        []
      end
    else
      self.products if self.products
    end
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
    brand_photos = self.brands.map{|t| t.slider_photos}.flatten
    product_photos = self.products.map{|t| t.slider_photos}.flatten
    (self.photos + brand_photos + product_photos).compact
  end
  
  def cover_url(size="small")
    @cover_url ||= begin
      UtilityIds.cover_url(self, size="small")
    end
    @default_images = ["default/high_stride.jpeg","default/high_server.jpeg","default/fence_hop.jpeg","default/krausmusic.jpeg"]
    @default_images += ["default/cat1.jpg","default/sky_hang.jpeg","default/tunnel_hop.jpeg","default/picture-17.png"]
    @default_images += ["default/snakeoil_supplements_956.png","default/wild-office-space.png","default/boarded up store Lake Valley NM ghost town.jpg"]
    @cover_url ? @cover_url : @default_images[rand(11)]
  end

  def to_partial_path() 
    "categories/grid_cell" 
  end
  
  def to_param
    permalink
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
#  t.integer  "slide_order",     :default => 0
#  t.string   "cached_tag_list"
#  t.datetime "created_at",                         :null => false
#  t.datetime "updated_at",                         :null => false
#end