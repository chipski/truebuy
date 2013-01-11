class Category < ActiveRecord::Base
  belongs_to :parent
  has_many :photos, :as => :parent, :class_name => "Photo" 
  has_and_belongs_to_many :topics, :class_name => "Topic"   
  has_and_belongs_to_many :brands, :class_name => "Brand" 
  has_and_belongs_to_many :companies, :class_name => "Company" 
  has_and_belongs_to_many :products, :class_name => "Product" 
  
  attr_accessible :blurb, :body, :cached_tag_list, :cover, :keywords, :name, :permalink, :state, :type, :parent_id
  
  after_save :update_permalink    
  default_scope order(:slide_order) 
  #scope :active, lambda {|current_user| where(:state=>:active)}     
  #scope :initial, where(:state=>["new","", nil])
  def self.select_active
    all.collect{ |t| [t.name, t.id]}
  end
  
  def self.filter_by_ids(category_ids="all", page=nil)
    category_ids = category_ids.to_a
    if category_ids.is_a?(Array)
      Category.find(category_ids)
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

  def products_filtered(brand_ids="all")
    if brand_ids == "all"
      self.products
    else
      if brand_ids.is_a?(Array)
        self.products.where({:brand_id => brand_ids}).all
      else
        Rails.logger.info("category.products_filtered no products found for brand_ids=#{brand_ids}")
        []
      end
    end
  end
  
  def slider_photos
    brand_photos = self.brands.map{|t| t.slider_photos}.flatten
    (self.photos + brand_photos).compact
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
#  t.integer  "slide_order",     :default => 0
#  t.string   "cached_tag_list"
#  t.datetime "created_at",                         :null => false
#  t.datetime "updated_at",                         :null => false
#end