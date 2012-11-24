class Topic < ActiveRecord::Base
  
  has_many :photos, :dependent => :destroy  
  
  attr_accessible :blurb, :body, :keywords, :name, :permalink, :state, :type, :uid

end
