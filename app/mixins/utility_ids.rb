class UtilityIds
  
  def self.update_permalink(entity, name="")
    name = "#{entity.name}".gsub(" ", "_")  
    token = Digest::SHA1.hexdigest("#{entity.class}-#{entity.id}".gsub(" ", "_"))
    permalink = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
    if !entity.permalink || (entity.uid != token)
      entity.permalink = permalink
      entity.uid = token
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
  
  # Will update the slide_order integer across the range of child associations from the main parent entity.  
  # This method is called after update on any of the children with varing scopes.  Watch churn.
  def self.update_order(entity, children_names)
    siblings = []
    children_names.each do |children_name|
      new_children = entity.send(children_name)
      puts "#{entity.class.to_s}.update_order for #{new_children.count} new #{children_name}"
      siblings += new_children
    end
    siblings_sorted = siblings.sort_by{|s| s.slide_order}
    puts "updated order #{siblings_sorted.map{|s| [s.id, s.slide_order]}}"
    i=entity.slide_order
    sort_return = siblings_sorted.map{|s| [s.id, s.slide_order == i ? "skip" : (s.slide_order = i+=1;s.save;) ]}
    puts "updated order #{siblings_sorted.map{|s| [s.id, s.slide_order]}} sort_return=#{sort_return}"
    #save_return = siblings_sorted.map{|s| [s.id, s.save]}
    #siblings.sort()
  end
end