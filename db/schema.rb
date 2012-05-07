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

ActiveRecord::Schema.define(:version => 20120331051839) do

  create_table "achievements", :force => true do |t|
    t.string   "type"
    t.integer  "level"
    t.integer  "achievable_id"
    t.string   "achievable_type"
    t.integer  "ref_id"
    t.string   "ref_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", :force => true do |t|
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "permalink",                                          :null => false
    t.string   "name",                                               :null => false
    t.text     "description",                                        :null => false
    t.integer  "bonus_points",       :limit => 3, :default => 0
    t.integer  "participants_count",              :default => 0
    t.integer  "period",             :limit => 1, :default => 1
    t.datetime "due_on"
    t.boolean  "published",                       :default => false
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["name"], :name => "index_challenges_on_name", :unique => true
  add_index "challenges", ["permalink"], :name => "index_challenges_on_permalink"

  create_table "challenges_feats", :id => false, :force => true do |t|
    t.integer "feat_id"
    t.integer "challenge_id"
  end

  add_index "challenges_feats", ["challenge_id", "feat_id"], :name => "index_challenges_feats_on_challenge_id_and_feat_id", :unique => true
  add_index "challenges_feats", ["challenge_id"], :name => "index_challenges_feats_on_challenge_id"
  add_index "challenges_feats", ["feat_id", "challenge_id"], :name => "Index_challenges_feats", :unique => true

  create_table "checkins", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "feat_id",                       :null => false
    t.text     "memo"
    t.boolean  "epic",       :default => false
    t.integer  "privacy"
    t.string   "location"
    t.datetime "created_at"
  end

  add_index "checkins", ["feat_id"], :name => "index_checkins_on_feat_id"
  add_index "checkins", ["user_id"], :name => "index_checkins_on_user_id"

  create_table "checkins_scheduled_tasks", :force => true do |t|
    t.integer "checkin_id"
    t.integer "scheduled_id"
    t.string  "scheduled_type"
    t.boolean "completed"
  end

  add_index "checkins_scheduled_tasks", ["checkin_id"], :name => "index_checkins_scheduled_tasks_on_checkin_id"
  add_index "checkins_scheduled_tasks", ["scheduled_id"], :name => "index_checkins_scheduled_tasks_on_scheduled_task_id"

  create_table "comments", :force => true do |t|
    t.integer  "checkin_id"
    t.integer  "user_id"
    t.string   "content"
    t.string   "user_ip"
    t.datetime "created_at"
  end

  add_index "comments", ["checkin_id"], :name => "index_comments_on_checkin_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "feats", :force => true do |t|
    t.string   "permalink"
    t.string   "name",          :limit => 100,                    :null => false
    t.text     "why"
    t.text     "how"
    t.integer  "bonus_points",  :limit => 2,   :default => 0
    t.integer  "checkin_count",                :default => 0
    t.boolean  "published",                    :default => false
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feats", ["name"], :name => "index_feats_on_name"
  add_index "feats", ["permalink"], :name => "index_feats_on_permalink"

  create_table "flaggings", :force => true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.string   "flagger_type"
    t.integer  "flagger_id"
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flaggings", ["flag", "flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flag_and_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flag", "flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flag_flaggings"
  add_index "flaggings", ["flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flaggings"

  create_table "frequencies", :force => true do |t|
    t.integer "value"
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

  create_table "scheduled_challenges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "due_on"
    t.datetime "completed_at"
    t.datetime "created_at"
  end

  add_index "scheduled_challenges", ["challenge_id"], :name => "index_scheduled_challenges_on_challenge_id"
  add_index "scheduled_challenges", ["user_id"], :name => "index_scheduled_challenges_on_user_id"

  create_table "scheduled_habits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "feat_id"
    t.integer  "frequency_id"
    t.datetime "created_at"
  end

  add_index "scheduled_habits", ["feat_id"], :name => "index_scheduled_habits_on_feat_id"
  add_index "scheduled_habits", ["user_id"], :name => "index_scheduled_habits_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shares", :force => true do |t|
    t.integer  "user_id"
    t.string   "shareable_type", :limit => 30
    t.integer  "shareable_id"
    t.string   "shared_to_type", :limit => 30
    t.integer  "shared_to_id"
    t.boolean  "restricted",                   :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
