# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130108030312) do

  create_table "brands", :force => true do |t|
    t.integer  "company_id"
    t.string   "uid"
    t.string   "permalink"
    t.string   "name"
    t.string   "keywords"
    t.text     "blurb"
    t.text     "body"
    t.string   "state",           :default => "new"
    t.string   "type"
    t.integer  "cover"
    t.string   "cached_tag_list"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "slide_order",     :default => 0
  end

  add_index "brands", ["company_id"], :name => "index_brands_on_company_id"
  add_index "brands", ["permalink"], :name => "index_brands_on_permalink", :unique => true
  add_index "brands", ["uid"], :name => "index_brands_on_uid", :unique => true

  create_table "brands_categories", :id => false, :force => true do |t|
    t.integer "brand_id"
    t.integer "category_id"
  end

  add_index "brands_categories", ["brand_id", "category_id"], :name => "index_brands_categories_on_brand_id_and_category_id"

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "uid"
    t.string   "permalink"
    t.string   "name"
    t.string   "keywords"
    t.text     "blurb"
    t.text     "body"
    t.string   "state",           :default => "new"
    t.string   "type"
    t.integer  "cover"
    t.string   "cached_tag_list"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "slide_order",     :default => 0
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["permalink"], :name => "index_categories_on_permalink", :unique => true
  add_index "categories", ["uid"], :name => "index_categories_on_uid", :unique => true

  create_table "categories_companies", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "company_id"
  end

  add_index "categories_companies", ["category_id", "company_id"], :name => "index_categories_companies_on_category_id_and_company_id"

  create_table "categories_products", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id", "product_id"], :name => "index_categories_products_on_category_id_and_product_id"

  create_table "categories_topics", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "topic_id"
  end

  add_index "categories_topics", ["category_id", "topic_id"], :name => "index_categories_topics_on_category_id_and_topic_id"

  create_table "companies", :force => true do |t|
    t.string   "uid"
    t.string   "permalink"
    t.string   "name"
    t.string   "keywords"
    t.text     "blurb"
    t.text     "body"
    t.string   "state",       :default => "new"
    t.string   "type"
    t.string   "duns"
    t.string   "url"
    t.string   "url2"
    t.integer  "cover"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "slide_order", :default => 0
  end

  add_index "companies", ["permalink"], :name => "index_companies_on_permalink", :unique => true
  add_index "companies", ["uid"], :name => "index_companies_on_uid", :unique => true

  create_table "photos", :force => true do |t|
    t.string   "uid"
    t.string   "permalink"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "name"
    t.string   "keywords"
    t.text     "blurb"
    t.string   "state",           :default => "new"
    t.string   "type"
    t.string   "image"
    t.string   "image_uid"
    t.string   "image_name"
    t.integer  "topic_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "cached_tag_list"
    t.integer  "slide_order",     :default => 0
  end

  add_index "photos", ["parent_id"], :name => "index_photos_on_parent_id"
  add_index "photos", ["parent_type", "parent_id"], :name => "index_photos_on_parent_type_and_parent_id"
  add_index "photos", ["permalink"], :name => "index_photos_on_permalink", :unique => true
  add_index "photos", ["uid"], :name => "index_photos_on_uid", :unique => true

  create_table "products", :force => true do |t|
    t.integer  "brand_id"
    t.string   "uid"
    t.string   "permalink"
    t.string   "name"
    t.string   "keywords"
    t.string   "url"
    t.integer  "topic_id"
    t.text     "blurb"
    t.text     "body"
    t.string   "state",            :default => "new"
    t.string   "type"
    t.date     "active_date"
    t.date     "deactivated_date"
    t.integer  "cover"
    t.string   "model_num"
    t.string   "sku"
    t.string   "sku_type"
    t.integer  "slide_order",      :default => 0
    t.string   "cached_tag_list"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"
  add_index "products", ["permalink"], :name => "index_products_on_permalink", :unique => true
  add_index "products", ["uid"], :name => "index_products_on_uid", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "topics", :force => true do |t|
    t.string   "uid"
    t.string   "permalink"
    t.string   "name"
    t.string   "keywords"
    t.text     "blurb"
    t.text     "body"
    t.string   "state",           :default => "new"
    t.string   "type"
    t.integer  "cover"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "company_id"
    t.integer  "brand_id"
    t.string   "cached_tag_list"
    t.integer  "slide_order",     :default => 0
  end

  add_index "topics", ["company_id"], :name => "index_topics_on_company_id"
  add_index "topics", ["permalink"], :name => "index_topics_on_permalink", :unique => true
  add_index "topics", ["uid"], :name => "index_topics_on_uid", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "opt_in"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
