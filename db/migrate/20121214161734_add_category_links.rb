class AddCategoryLinks < ActiveRecord::Migration
  def up
    add_column :topics, :brand_id, :integer
    add_column :topics, :cached_tag_list, :string
    add_column :photos, :cached_tag_list, :string
    
    create_table(:categories_companies, :id => false, :force=>true) do |t|
       t.references :category
       t.references :company
    end
    add_index(:categories_companies, [ :category_id, :company_id ])
    
    create_table(:categories_topics, :id => false) do |t|
       t.references :category
       t.references :topic
    end
    add_index(:categories_topics, [ :category_id, :topic_id ])
    
    create_table(:categories_brands, :id => false) do |t|
       t.references :category
       t.references :brand
    end
    add_index(:categories_brands, [ :category_id, :brand_id ])
    
    
  end

  def down
    remove_column :topics, :brand_id
    remove_column :topics, :cached_tag_list
    remove_column :photos, :cached_tag_list
    
    drop_table :categories_brands
    drop_table :categories_topics
    drop_table :categories_companies
  end
end
