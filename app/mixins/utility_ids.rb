class UtilityIds
  
  def self.update_permalink(entity, name="")
    name = "#{entity.name}".gsub(" ", "_")  
    token = Digest::SHA1.hexdigest("#{entity.class}-#{entity.id}".gsub(" ", "_"))
    permalink = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    if entity.permalink != permalink
      entity.update_attribute(:permalink, permalink)
      entity.update_attribute(:uid, token)
    end      
  end  
  
  def self.update_permalink2(entity)
    name = "#{entity.class}-#{entity.id}-#{entity.name}".gsub(" ", "_")  
    token = Digest::SHA1.hexdigest("#{entity.class}-#{entity.id}".gsub(" ", "_"))
    permalink = Digest::SHA1.hexdigest(name)
    if entity.permalink != permalink
      entity.update_attribute(:permalink, permalink)
      entity.update_attribute(:uid, token)
    end      
  end
  
  def self.cover_url(entity, size="small")
    if entity.cover 
      photo = Photo.find_by_id(entity.cover)
      Rails.logger.info("#{entity.class}.cover_url photo=#{photo} found for id=#{entity.cover}")
      if photo 
        if size == "large"
          photo.image.large.url 
        elsif size == "small"
          photo.image.small.url 
        elsif size == "full"
          photo.image.url 
        else
          photo.image.thumb.url
        end 
      end
    end
  end
  
end