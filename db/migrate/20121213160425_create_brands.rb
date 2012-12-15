class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.references :company
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.text :body
      t.string :state, :default=>"new"
      t.string :type
      t.integer :cover
      t.string :cached_tag_list

      t.timestamps
    end
    add_index :brands, :company_id
    add_index :brands, :uid, :unique => true
    add_index :brands, :permalink, :unique => true
    
  end
end
