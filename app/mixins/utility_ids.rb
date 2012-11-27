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
    name = "#{entity.name} #{entity.class}-#{entity.id}".gsub(" ", "_")  
    token = Digest::SHA1.hexdigest("#{entity.class}-#{entity.id}".gsub(" ", "_"))
    permalink = Digest::SHA1.hexdigest(name)
    if entity.permalink != permalink
      entity.update_attribute(:permalink, permalink)
      entity.update_attribute(:uid, token)
    end      
  end
  
end