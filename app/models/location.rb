class Location < ActiveRecord::Base
  belongs_to :store
  belongs_to :user
  attr_accessible :street, :city, :us_state, :zipcode, :country, :phone, :latitude, :longitude
  attr_accessible :state, :type, :uid, :name, :permalink,:blurb, :cached_tag_list,:keywords, :store_id, :user_id

  reverse_geocoded_by :latitude, :longitude, :address => :full_address
  geocoded_by :address               # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  after_validation :reverse_geocode  # auto-fetch address
  
  def address
    [street, city, us_state, country].compact.join(', ')
  end
  def put_address(full_address)
    self.update_attribute(:full_address, full_address)
  end
  
  def from_location(location)
    puts "Location.from_location #{location.inspect}"
    
  end
  
  def self.from_fb(location_hash, user)
    return unless location_hash
    Rails.logger.info("Location.from_fb #{location_hash.inspect}")
    @location_hash = location_hash.delete("id")
    @location_hash["user_id"] = user.id
    @location = Location.create(@location_hash)
  end
  
  def display_address
    "#{self.city} #{self.us_state} #{self.country}"
  end
  def full_address
    "#{self.street} #{self.city} #{self.us_state} #{self.zipcode} #{self.country}"
  end
  def zip=(zipcode)
    self.update_attribute(:zipcode, zipcode)
  end
  def state=(us_state)
    self.update_attribute(:us_state, us_state)
  end


end

#create_table "locations", :force => true do |t|
#  t.integer  "store_id"
#  t.integer  "user_id"
#  t.string   "uid"
#  t.string   "permalink"
#  t.string   "name"
#  t.string   "keywords"
#  t.text     "blurb"
#  t.string   "state"
#  t.string   "type"
#  t.string   "cached_tag_list"
#  t.string   "ip_address"
#  t.string   "full_address"
#  t.string   "street"
#  t.string   "city"
#  t.string   "us_state"
#  t.string   "country"
#  t.string   "zipcode"
#  t.float    "latitude"
#  t.float    "longitude"
#  t.string   "phone"
#  t.datetime "created_at",      :null => false
#  t.datetime "updated_at",      :null => false
#end