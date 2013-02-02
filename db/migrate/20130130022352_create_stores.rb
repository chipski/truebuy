class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.string :state
      t.string :type
      t.string :url
      t.string :url2
      t.string :store_id
      t.boolean :realtime_availability

      t.timestamps
    end
    add_index :stores, :uid, :unique => true
    add_index :stores, :permalink, :unique => true
    
    add_column :products, :price, :float, :default=>0.0
      
  end
end
