class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true
  
  attr_accessible :rate, :dimension
  
end

#create_table "rates", :force => true do |t|
#    t.integer  "rater_id"
#    t.integer  "rateable_id"
#    t.string   "rateable_type"
#    t.float    "stars",         :null => false
#    t.string   "dimension"
#    t.datetime "created_at",    :null => false
#    t.datetime "updated_at",    :null => false
#  end