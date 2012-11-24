class Photo < ActiveRecord::Base
  
  
  attr_accessible :blurb, :image_name, :image_uid, :keywords, :name, :permalink, :state, :type, :uid   
  
  attr_accessible :description, :topic_id, :image, :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :topic
  
  mount_uploader :image, ImageUploader

  after_update :crop_image

  def to_jq_upload
    {
      "name" => read_attribute(:image),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => id,
      "picture_id" => id,
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
  
  
end
