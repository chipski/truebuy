class AddUserUuid < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string
    add_column :users, :analytics_id, :string
    add_column :users, :rating_count, :string
    add_column :users, :rating_average, :string
    add_column :users, :review_count, :string
    add_column :users, :email_count, :string
  end
end
