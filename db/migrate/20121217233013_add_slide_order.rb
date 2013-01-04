class AddSlideOrder < ActiveRecord::Migration
  def up
    add_column :companies, :slide_order, :integer, :default=>0
    add_column :brands, :slide_order, :integer, :default=>0
    add_column :categories, :slide_order, :integer, :default=>0
    add_column :topics, :slide_order, :integer, :default=>0
    add_column :photos, :slide_order, :integer, :default=>0
  end

  def down
    remove_column :companies, :slide_order
    remove_column :brands, :slide_order
    remove_column :categories, :slide_order
    remove_column :topics, :slide_order
    remove_column :photos, :slide_order
  end
end
