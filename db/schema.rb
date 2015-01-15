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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "oauth_access_grants", force: :cascade, comment: "OAuthアクセスグラント" do |t|
    t.integer  "resource_owner_id", null: false, comment: "リソース所有者ID"
    t.integer  "application_id",    null: false, comment: "アプリケーションID"
    t.string   "token",             null: false, comment: "アクセストークン"
    t.integer  "expires_in",        null: false, comment: "有効期限"
    t.text     "redirect_uri",      null: false, comment: "コールバックURL"
    t.datetime "created_at",        null: false, comment: "作成日時"
    t.datetime "revoked_at",                     comment: "無効化日時"
    t.string   "scopes",                         comment: "スコープ"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade, comment: "OAuthアクセストークン" do |t|
    t.integer  "resource_owner_id",              comment: "リソース所有者ID"
    t.integer  "application_id",                 comment: "アプリケーションID"
    t.string   "token",             null: false, comment: "アクセストークン"
    t.string   "refresh_token",                  comment: "リフレッシュトークン"
    t.integer  "expires_in",                     comment: "有効期限"
    t.datetime "revoked_at",                     comment: "無効化日時"
    t.datetime "created_at",        null: false, comment: "作成日時"
    t.string   "scopes",                         comment: "スコープ"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade, comment: "OAuthアプリケーション" do |t|
    t.string   "name",         null: false, comment: "名称"
    t.string   "uid",          null: false, comment: "アプリケーションID"
    t.string   "secret",       null: false, comment: "シークレット"
    t.text     "redirect_uri", null: false, comment: "コールバックURL"
    t.datetime "created_at",   null: false, comment: "作成日時"
    t.datetime "updated_at",   null: false, comment: "更新日時"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "roles", force: :cascade, comment: "ロールマスタ" do |t|
    t.string   "code",                    null: false, comment: "コード"
    t.string   "name",       default: "", null: false, comment: "名称"
    t.integer  "sort",                                 comment: "並び順"
    t.datetime "created_at",              null: false, comment: "作成日時"
    t.datetime "updated_at",              null: false, comment: "更新日時"
  end

  add_index "roles", ["code"], name: "index_roles_on_code", unique: true, using: :btree
  add_index "roles", ["created_at"], name: "index_roles_on_created_at", using: :btree
  add_index "roles", ["updated_at"], name: "index_roles_on_updated_at", using: :btree

  create_table "sessions", force: :cascade, comment: "セッションデータ" do |t|
    t.string   "session_id", null: false, comment: "セッションID"
    t.text     "data",                    comment: "データ"
    t.datetime "created_at", null: false, comment: "作成日時"
    t.datetime "updated_at", null: false, comment: "更新日時"
  end

  add_index "sessions", ["created_at"], name: "index_sessions_on_created_at", using: :btree
  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade, comment: "ユーザーマスタ" do |t|
    t.string   "key",                                 null: false, comment: "固有キー"
    t.string   "name",                   default: "", null: false, comment: "ユーザー名"
    t.string   "nick_name",              default: "", null: false, comment: "ニックネーム"
    t.string   "email",                  default: "", null: false, comment: "メールアドレス"
    t.string   "encrypted_password",     default: "", null: false, comment: "パスワード(ハッシュ値)"
    t.string   "reset_password_token",                             comment: "パスワードリセットトークン"
    t.datetime "reset_password_sent_at",                           comment: "パスワードリセット要求日時"
    t.datetime "remember_created_at",                              comment: "次回自動指定でのログイン日時"
    t.integer  "sign_in_count",          default: 0,  null: false, comment: "ログイン回数"
    t.datetime "current_sign_in_at",                               comment: "今回ログイン日時"
    t.datetime "last_sign_in_at",                                  comment: "前回ログイン日時"
    t.string   "current_sign_in_ip",                               comment: "今回アクセス元IP"
    t.string   "last_sign_in_ip",                                  comment: "前回アクセス元IP"
    t.string   "confirmation_token",                               comment: "登録確認トークン"
    t.datetime "confirmed_at",                                     comment: "登録確認済み日時"
    t.datetime "confirmation_sent_at",                             comment: "登録確認要求日時"
    t.string   "unconfirmed_email",                                comment: "未確認メールアドレス"
    t.string   "twitter_uid",                                      comment: "TwitterアカウントUID"
    t.string   "facebook_uid",                                     comment: "FacebookアカウントUID"
    t.string   "google_uid",                                       comment: "GoogleアカウントUID"
    t.integer  "failed_attempts",        default: 0,  null: false, comment: "認証失敗回数"
    t.string   "unlock_token",                                     comment: "アカウントロック解除トークン"
    t.datetime "locked_at",                                        comment: "アカウントロック日時"
    t.string   "image_file_name",                                  comment: "画像ファイル名"
    t.string   "image_content_type",                               comment: "画像MIMEタイプ"
    t.integer  "image_file_size",                                  comment: "画像ファイルサイズ"
    t.datetime "image_updated_at",                                 comment: "画像更新日時"
    t.text     "bio",                                              comment: "自己紹介"
    t.text     "note",                                             comment: "メモ"
    t.datetime "created_at",                          null: false, comment: "作成日時"
    t.datetime "updated_at",                          null: false, comment: "更新日時"
    t.datetime "deleted_at",                                       comment: "削除日時"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["deleted_at", "facebook_uid"], name: "index_users_on_deleted_at_and_facebook_uid", unique: true, using: :btree
  add_index "users", ["deleted_at", "google_uid"], name: "index_users_on_deleted_at_and_google_uid", unique: true, using: :btree
  add_index "users", ["deleted_at", "key"], name: "index_users_on_deleted_at_and_key", unique: true, using: :btree
  add_index "users", ["deleted_at", "twitter_uid"], name: "index_users_on_deleted_at_and_twitter_uid", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["updated_at"], name: "index_users_on_updated_at", using: :btree

  create_table "users_roles", force: :cascade, comment: "ユーザー：ロール" do |t|
    t.integer "user_id", null: false, comment: "ユーザーID"
    t.integer "role_id", null: false, comment: "ロールID"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true, using: :btree

  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
end
