class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :parent
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
    add_index :categories, :parent_id
    add_index :categories, :uid, :unique => true
    add_index :categories, :permalink, :unique => true
  end
end
