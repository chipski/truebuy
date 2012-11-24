class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
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
    add_index :topics, :uid, :unique => true
    add_index :topics, :permalink, :unique => true
    add_index :topics, :photo_id
  end
end
