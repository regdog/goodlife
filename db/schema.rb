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

ActiveRecord::Schema.define(:version => 20111017123453) do

  create_table "accepted_challenges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "accepted_on"
    t.datetime "complete_on"
  end

  add_index "accepted_challenges", ["user_id"], :name => "index_accepted_challenges_on_user_id"

  create_table "admin_users", :force => true do |t|
    t.integer  "partner_id"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", :force => true do |t|
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "name",                              :null => false
    t.text     "description",                       :null => false
    t.integer  "bonus_points"
    t.integer  "participants_count", :default => 0
    t.datetime "start_on"
    t.datetime "end_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["name"], :name => "index_challenges_on_name", :unique => true

  create_table "challenges_checkins", :id => false, :force => true do |t|
    t.integer "challenge_id"
    t.integer "checkin_id"
  end

  add_index "challenges_checkins", ["challenge_id", "checkin_id"], :name => "index_challenges_checkins_on_challenge_id_and_checkin_id", :unique => true

  create_table "challenges_feats", :id => false, :force => true do |t|
    t.integer "feat_id"
    t.integer "challenge_id"
  end

  add_index "challenges_feats", ["challenge_id", "feat_id"], :name => "index_challenges_feats_on_challenge_id_and_feat_id", :unique => true

  create_table "checkins", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "feat_id",    :null => false
    t.text     "memo"
    t.integer  "public"
    t.string   "user_ip"
    t.datetime "created_at"
  end

  add_index "checkins", ["user_id", "feat_id"], :name => "index_checkins_on_user_id_and_feat_id"

  create_table "comments", :force => true do |t|
    t.integer  "checkin_id"
    t.integer  "users_id"
    t.string   "content"
    t.string   "user_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "admin_user_id"
    t.string   "permalink",                                      :null => false
    t.string   "title",         :limit => 100, :default => "",   :null => false
    t.text     "content",                                        :null => false
    t.boolean  "draft",                        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["permalink"], :name => "index_contents_on_permalink", :unique => true

  create_table "feats", :force => true do |t|
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "name",          :limit => 60,                    :null => false
    t.text     "why"
    t.text     "how"
    t.integer  "bonus_points",  :limit => 3,  :default => 0
    t.integer  "checkin_count",               :default => 0
    t.boolean  "published",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kindeditor_images", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", :force => true do |t|
    t.integer  "tag_id"
    t.string   "name",        :null => false
    t.text     "description"
    t.string   "website"
    t.string   "country"
    t.string   "region"
    t.string   "city"
    t.string   "street"
    t.string   "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planned_todos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feat_id"
    t.string   "plan_type"
    t.datetime "created_at"
  end

  add_index "planned_todos", ["user_id", "feat_id"], :name => "index_planned_todos_on_user_id_and_feat_id", :unique => true

  create_table "redemptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reward_id"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "phone"
    t.datetime "created_at"
  end

  add_index "redemptions", ["user_id"], :name => "index_redemptions_on_user_id"

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
    t.integer  "partner_id"
    t.string   "name",                                                       :null => false
    t.text     "description",                                                :null => false
    t.integer  "redeem_points"
    t.decimal  "save_money",    :precision => 8, :scale => 2
    t.integer  "redeem_count",                                :default => 0
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
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.string  "kind"
    t.integer "position"
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind", :unique => true

  create_table "uploads", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.string   "type"
  end

  add_index "uploads", ["attachable_id", "attachable_type"], :name => "index_uploads_on_attachable_id_and_attachable_type"

  create_table "user_wishes", :force => true do |t|
    t.integer "user_id"
    t.integer "reward_id"
  end

  add_index "user_wishes", ["user_id", "reward_id"], :name => "index_user_wishes_on_user_id_and_reward_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                                               :default => "",  :null => false
    t.string   "encrypted_password",     :limit => 128,                               :default => ""
    t.string   "name"
    t.integer  "earned_points",          :limit => 8,                                 :default => 0
    t.decimal  "life_score",                            :precision => 2, :scale => 1, :default => 0.0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                                                     :default => 0
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
