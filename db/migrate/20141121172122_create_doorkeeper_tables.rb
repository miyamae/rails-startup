class CreateDoorkeeperTables < ActiveRecord::Migration

  def change

    create_table :oauth_applications, comment: 'OAuthアプリケーション' do |t|
      t.string  :name,         null: false, comment: '名称'
      t.string  :uid,          null: false, comment: 'アプリケーションID'
      t.string  :secret,       null: false, comment: 'シークレット'
      t.text    :redirect_uri, null: false, comment: 'コールバックURL'
      t.datetime :created_at,  null: false, comment: '作成日時'
      t.datetime :updated_at,  null: false, comment: '更新日時'
    end

    add_index :oauth_applications, :uid, unique: true

    create_table :oauth_access_grants, comment: 'OAuthアクセスグラント' do |t|
      t.integer  :resource_owner_id, null: false, foreign_key: false, comment: 'リソース所有者ID'
      t.integer  :application_id,    null: false, foreign_key: false, comment: 'アプリケーションID'
      t.string   :token,             null: false, comment: 'アクセストークン'
      t.integer  :expires_in,        null: false, comment: '有効期限'
      t.text     :redirect_uri,      null: false, comment: 'コールバックURL'
      t.datetime :created_at,        null: false, comment: '作成日時'
      t.datetime :revoked_at,        comment: '無効化日時'
      t.string   :scopes,            comment: 'スコープ'
    end

    add_index :oauth_access_grants, :token, unique: true

    create_table :oauth_access_tokens, comment: 'OAuthアクセストークン' do |t|
      t.integer  :resource_owner_id, foreign_key: false, comment: 'リソース所有者ID'
      t.integer  :application_id,    foreign_key: false, comment: 'アプリケーションID'
      t.string   :token,             null: false, comment: 'アクセストークン'
      t.string   :refresh_token,     comment: 'リフレッシュトークン'
      t.integer  :expires_in,        comment: '有効期限'
      t.datetime :revoked_at,        comment: '無効化日時'
      t.datetime :created_at,        null: false, comment: '作成日時'
      t.string   :scopes,            comment: 'スコープ'
    end

    add_index :oauth_access_tokens, :token, unique: true
    add_index :oauth_access_tokens, :resource_owner_id
    add_index :oauth_access_tokens, :refresh_token, unique: true

  end

end
