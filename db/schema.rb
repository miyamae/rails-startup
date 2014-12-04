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

  create_table "oauth_access_grants", force: true, comment: "OAuthアクセスグラント" do |t|
    t.integer  "resource_owner_id", null: false, comment: "リソース所有者ID"
    t.integer  "application_id",    null: false, comment: "アプリケーションID"
    t.string   "token",             null: false, comment: "アクセストークン"
    t.integer  "expires_in",        null: false, comment: "有効期限"
    t.text     "redirect_uri",      null: false, comment: "コールバックURL"
    t.datetime "created_at",        null: false, comment: "作成日時"
    t.datetime "revoked_at",                     comment: "無効化日時"
    t.string   "scopes",                         comment: "スコープ"
    t.index ["token"], :name => "index_oauth_access_grants_on_token", :unique => true
  end

  create_table "oauth_access_tokens", force: true, comment: "OAuthアクセストークン" do |t|
    t.integer  "resource_owner_id",              comment: "リソース所有者ID"
    t.integer  "application_id",                 comment: "アプリケーションID"
    t.string   "token",             null: false, comment: "アクセストークン"
    t.string   "refresh_token",                  comment: "リフレッシュトークン"
    t.integer  "expires_in",                     comment: "有効期限"
    t.datetime "revoked_at",                     comment: "無効化日時"
    t.datetime "created_at",        null: false, comment: "作成日時"
    t.string   "scopes",                         comment: "スコープ"
    t.index ["refresh_token"], :name => "index_oauth_access_tokens_on_refresh_token", :unique => true
    t.index ["resource_owner_id"], :name => "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], :name => "index_oauth_access_tokens_on_token", :unique => true
  end

  create_table "oauth_applications", force: true, comment: "OAuthアプリケーション" do |t|
    t.string   "name",         null: false, comment: "名称"
    t.string   "uid",          null: false, comment: "アプリケーションID"
    t.string   "secret",       null: false, comment: "シークレット"
    t.text     "redirect_uri", null: false, comment: "コールバックURL"
    t.datetime "created_at",   null: false, comment: "作成日時"
    t.datetime "updated_at",   null: false, comment: "更新日時"
    t.index ["uid"], :name => "index_oauth_applications_on_uid", :unique => true
  end

  create_table "roles", force: true, comment: "ロールマスタ" do |t|
    t.string   "code",                    null: false, comment: "コード"
    t.string   "name",       default: "", null: false, comment: "名称"
    t.integer  "sort",                                 comment: "並び順"
    t.datetime "created_at",              null: false, comment: "作成日時"
    t.datetime "updated_at",              null: false, comment: "更新日時"
    t.index ["code"], :name => "index_roles_on_code", :unique => true
  end

  create_table "sessions", force: true, comment: "セッションデータ" do |t|
    t.string   "session_id", null: false, comment: "セッションID"
    t.text     "data",                    comment: "データ"
    t.datetime "created_at", null: false, comment: "作成日時"
    t.datetime "updated_at", null: false, comment: "更新日時"
    t.index ["created_at"], :name => "index_sessions_on_created_at"
    t.index ["session_id"], :name => "index_sessions_on_session_id", :unique => true
    t.index ["updated_at"], :name => "index_sessions_on_updated_at"
  end

  create_table "users", force: true, comment: "ユーザーマスタ" do |t|
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
    t.index ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
    t.index ["created_at"], :name => "index_users_on_created_at"
    t.index ["email"], :name => "index_users_on_email"
    t.index ["key"], :name => "index_users_on_key", :unique => true
    t.index ["name"], :name => "index_users_on_name"
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    t.index ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true
    t.index ["updated_at"], :name => "index_users_on_updated_at"
  end

  create_table "users_roles", force: true, comment: "ユーザー：ロール" do |t|
    t.integer "user_id", null: false, comment: "ユーザーID"
    t.integer "role_id", null: false, comment: "ロールID"
    t.index ["role_id", "user_id"], :name => "index_users_roles_on_role_id_and_user_id", :unique => true
    t.index ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id", :unique => true
    t.foreign_key ["role_id"], "roles", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_roles_role_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_users_roles_user_id"
  end

end
