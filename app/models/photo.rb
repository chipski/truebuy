class Photo < ActiveRecord::Base

  attr_accessible :blurb, :image_name, :image_uid, :image, :keywords, :name, :permalink, :parent_id, :parent_type, :topic_id, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :topic     
  belongs_to :parent, :polymorphic => true #, :counter_cache => true
  
  
  include Rails.application.routes.url_helpers
  mount_uploader :image, ImageUploader        
  
  after_save :update_permalink
  #after_update :crop_image
  
  default_scope order(:updated_at) 
  scope :active, lambda {|current_user| where(:state=>:active)}     
  scope :inactive, lambda {|current_user| where(:state=>[:inactive])}      
  scope :initial, where(:state=>[:new, nil])  
  
  def self.select_active         
    self.initial.collect{ |t| [" #{t.name[0..30]}", t.id]}
  end

  def self.default_parent
    Topic.find_by_name("Lost & Found") || Topic.first
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "small_url" => image.small.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => photo_path(:id => id),
      "parent_path" => parent ? polymorphic_path([parent, self]) : "", 
      "photo_id" => id,
      "delete_type" => "DELETE"
    }
  end

  def crop_image
    image.recreate_versions! if crop_x.present?
    current_version = self.image.current_path
    large_version = "#{Rails.root}/public" + self.image.versions[:large].to_s

    FileUtils.rm(current_version)
    FileUtils.cp(large_version, current_version)
  end
  
  def update_permalink
    unless name
      update_attribute(:name, (image.identifier ? image.identifier : image.path)) 
    end
    UtilityIds.update_permalink2(self) 
  end
  
end

#create_table "photos", :force => true do |t|
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.integer :parent_id
#  t.string :parent_type
#  t.string   "state"
#  t.string   "type"
#  t.string   "image_url"
#  t.string   "image_uid"
#  t.string   "image_name"
#  t.integer  "topic_id"
#  t.datetime "created_at", :null => false
#  t.datetime "updated_at", :null => false
#end
#