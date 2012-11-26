class Photo < ActiveRecord::Base

  attr_accessible :blurb, :image_name, :image_uid, :image, :keywords, :name, :permalink, :uid, :topic_id, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :topic   
  
  include Rails.application.routes.url_helpers
  mount_uploader :image, ImageUploader        
  
  after_save :update_permalink
  #after_update :crop_image
  

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => photo_path(:id => id),
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
    secret = "p#{self.name}_#{self.id}".gsub(" ", "_")  # add random
    permalink = Digest::SHA2.hexdigest(secret)
    token = Digest::SHA1.hexdigest(secret)
    if self.permalink != permalink
      self.update_attribute(:permalink, permalink)
      self.update_attribute(:uid, token)
    end      
  end
  
end

#create_table "photos", :force => true do |t|
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
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