class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.string :state
      t.string :type
      t.string :image
      t.string :image_uid
      t.string :image_name
      t.references :topic

      t.timestamps
    end
    add_index :photos, :uid, :unique => true
    add_index :photos, :permalink, :unique => true
    add_index :photos, :topic_id
  end
end
