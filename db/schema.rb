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

ActiveRecord::Schema.define(:version => 20110904120910) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description", :null => false
    t.integer  "bonus_point"
    t.integer  "done_count"
    t.datetime "start_on"
    t.datetime "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["name"], :name => "index_challenges_on_name", :unique => true

  create_table "challenges_feats", :id => false, :force => true do |t|
    t.integer  "feat_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "checkin_id"
    t.integer  "user_id"
    t.text     "content"
    t.string   "user_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_nodes", :force => true do |t|
    t.string   "name",       :limit => 100, :default => "", :null => false
    t.string   "title",      :limit => 100, :default => "", :null => false
    t.text     "content",                                   :null => false
    t.datetime "display_on",                                :null => false
    t.string   "type",       :limit => 50,                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_nodes", ["id", "type"], :name => "index_on_content_nodes", :unique => true

  create_table "feats", :force => true do |t|
    t.string   "title",          :limit => 20,                :null => false
    t.string   "description",    :limit => 60,                :null => false
    t.text     "why"
    t.text     "how"
    t.integer  "bonus_point"
    t.integer  "done_count",                   :default => 0
    t.date     "date_available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "requestor_id",                     :null => false
    t.string   "requestor_type",                   :null => false
    t.integer  "requestee_id",                     :null => false
    t.string   "requestee_type",                   :null => false
    t.boolean  "restricted",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rewards", :force => true do |t|
    t.string   "name",                                       :null => false
    t.text     "description"
    t.integer  "redeem_point"
    t.float    "save_money"
    t.decimal  "redeem_count", :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.string  "type"
    t.integer "parent_id"
  end

  add_index "tags", ["name", "type"], :name => "index_tags_on_name_and_type", :unique => true

  create_table "uploads", :force => true do |t|
    t.string   "filename"
    t.integer  "width",        :default => 0, :null => false
    t.integer  "height",       :default => 0, :null => false
    t.string   "type"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "thumbnail"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => ""
    t.string   "name",                                  :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
