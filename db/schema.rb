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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141121172122) do

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], :name => "index_oauth_access_grants_on_token", :unique => true
  end

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
    t.index ["refresh_token"], :name => "index_oauth_access_tokens_on_refresh_token", :unique => true
    t.index ["resource_owner_id"], :name => "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], :name => "index_oauth_access_tokens_on_token", :unique => true
  end

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["uid"], :name => "index_oauth_applications_on_uid", :unique => true
  end

  create_table "roles", force: true do |t|
    t.string   "code",                    null: false
    t.string   "name",       default: "", null: false
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], :name => "index_roles_on_code", :unique => true
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], :name => "index_sessions_on_session_id", :unique => true
    t.index ["updated_at"], :name => "index_sessions_on_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "key",                                 null: false
    t.string   "name",                   default: "", null: false
    t.string   "nick_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "twitter_uid"
    t.string   "facebook_uid"
    t.string   "google_uid"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "bio"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
    t.index ["created_at"], :name => "index_users_on_created_at"
    t.index ["email"], :name => "index_users_on_email"
    t.index ["key"], :name => "index_users_on_key", :unique => true
    t.index ["name"], :name => "index_users_on_name"
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
    t.index ["updated_at"], :name => "index_users_on_updated_at"
  end

  create_table "users_roles", force: true do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["role_id", "user_id"], :name => "index_users_roles_on_role_id_and_user_id", :unique => true
    t.index ["user_id"], :name => "fk__users_roles_user_id"
    t.foreign_key ["role_id"], "roles", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_roles_role_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_roles_user_id"
  end

end
