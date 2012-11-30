class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :uid
      t.string :permalink
      t.string :name
      t.string :keywords
      t.text :blurb
      t.text :body
      t.string :state, :default=>"new"
      t.string :type
      t.string :duns
      t.string :url
      t.string :url2
      t.integer :cover

      t.timestamps
    end
    add_index :companies, :uid, :unique => true
    add_index :companies, :permalink, :unique => true     
    
    add_column :topics, :company_id, :integer
    add_index :topics, :company_id
  end
end
