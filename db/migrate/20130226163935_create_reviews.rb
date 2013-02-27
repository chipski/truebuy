class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :product
      t.references :user
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.text :body
      t.string :state, :default=>:new
      t.string :type
      t.date :active_date
      t.date :deactivated_date
      t.integer :slide_order,     :default => 0
      t.string :cached_tag_list

      t.timestamps
    end
    add_index :reviews, :product_id
    add_index :reviews, :uid, :unique => true
    add_index :reviews, :permalink, :unique => true
    add_index :reviews, :user_id
  end
end
