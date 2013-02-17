class AddUserInfo < ActiveRecord::Migration
  def change
    add_column :users, :password, :string
    add_column :users, :fb_token, :string
    add_column :users, :state, :string, :default=>:new
    add_column :users, :status, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :avatar_url, :string
    add_column :users, :profile_url, :string
    add_column :users, :date_of_birth, :datetime
    add_column :users, :hometown, :string
    add_column :users, :about, :text
    
  end
end
