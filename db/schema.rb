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

ActiveRecord::Schema.define(:version => 20101017202926) do

  create_table "agrees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "must_id"
    t.integer  "calification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "must_id"
    t.integer  "job_id"
    t.integer  "format1_id"
    t.integer  "format2_id"
    t.string   "format1_url"
    t.string   "format2_url"
    t.string   "format1_label"
    t.string   "format2_label"
  end

  create_table "buckets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "must_id"
    t.boolean  "status",     :default => false
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

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.string   "favorable_type", :limit => 30
    t.integer  "favorable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "musts", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "url_image"
    t.boolean  "top"
    t.float    "top_value"
    t.string   "url_video"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
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
    t.string   "fb_access_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
