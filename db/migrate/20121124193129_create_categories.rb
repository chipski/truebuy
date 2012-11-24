class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.text :body
      t.string :state, :default=>:new   
      t.string :type
      t.references :photo

      t.timestamps
    end
    add_index :categories, :uid, :unique => true
    add_index :categories, :permalink, :unique => true
    add_index :categories, :photo_id
  end
end
