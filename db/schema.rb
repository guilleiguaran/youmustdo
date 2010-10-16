# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101016180825) do

  create_table "agrees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "must_id"
    t.integer  "calification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "must_id"
  end

  create_table "musts", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "url"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",  :limit => 128
    t.string   "salt",                :limit => 128
    t.string   "confirmation_token",  :limit => 128
    t.string   "remember_token",      :limit => 128
    t.boolean  "email_confirmed",                    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "twitter_id"
    t.string   "screen_name"
    t.string   "avatar_url"
    t.string   "access_token"
    t.string   "access_secret"
    t.integer  "facebook_uid"
    t.string   "name"
    t.string   "web"
    t.string   "location"
    t.text     "bio"
    t.string   "external_avatar_url"
    t.string   "avatar_type"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
