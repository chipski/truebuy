class AddProductsNow < ActiveRecord::Migration
  def change
    create_table :products, :force=>true do |t|
      t.references :brand
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.string :url
      t.integer :topic_id
      t.text :blurb
      t.text :body
      t.string :state, :default=>"new"
      t.string :type
      t.date :active_date
      t.date :deactivated_date
      t.integer :cover
      t.string :model_num
      t.string :sku
      t.string :sku_type
      t.integer :slide_order,     :default => 0
      t.string :cached_tag_list

      t.timestamps
    end
    add_index :products, :brand_id
    add_index :products, :uid, :unique => true
    add_index :products, :permalink, :unique => true
    
    create_table(:categories_products, :id => false, :force=>true) do |t|
       t.references :category
       t.references :product
    end
    add_index(:categories_products, [ :category_id, :product_id ])
    
  end
end
