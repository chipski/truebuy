class AddLocations < ActiveRecord::Migration
  def change
    create_table :locations, :force=>true do |t|
      t.references :store
      t.references :user
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.string :state
      t.string :type
      t.string :cached_tag_list
      t.string :ip_address
      t.string :full_address
      t.string :street
      t.string :city
      t.string :us_state
      t.string :country, :default=>"US"
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.string :phone

      t.timestamps
    end
    add_index :locations, :store_id
    add_index :locations, :user_id
    add_index :locations, :uid, :unique => true
    add_index :locations, :permalink, :unique => true
    
  end
end
