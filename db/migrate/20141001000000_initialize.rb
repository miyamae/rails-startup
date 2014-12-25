class Initialize < ActiveRecord::Migration

  def change

    create_table :users, comment: 'ユーザーマスタ' do |t|
      t.string :key,        null: false, comment: '固有キー'
      t.string :name,       null: false, default: '', comment: 'ユーザー名'
      t.string :nick_name,  null: false, default: '', comment: 'ニックネーム'

      ## Database authenticatable
      t.string :email,              null: false, default: '', comment: 'メールアドレス'
      t.string :encrypted_password, null: false, default: '', comment: 'パスワード(ハッシュ値)'

      ## Recoverable
      t.string   :reset_password_token,   comment: 'パスワードリセットトークン'
      t.datetime :reset_password_sent_at, comment: 'パスワードリセット要求日時'

      ## Rememberable
      t.datetime :remember_created_at, comment: '次回自動指定でのログイン日時'

      ## Trackable
      t.integer  :sign_in_count,      default: 0, null: false, comment: 'ログイン回数'
      t.datetime :current_sign_in_at, comment: '今回ログイン日時'
      t.datetime :last_sign_in_at,    comment: '前回ログイン日時'
      t.string   :current_sign_in_ip, comment: '今回アクセス元IP'
      t.string   :last_sign_in_ip,    comment: '前回アクセス元IP'

      ## Confirmable
      t.string   :confirmation_token,   comment: '登録確認トークン'
      t.datetime :confirmed_at,         comment: '登録確認済み日時'
      t.datetime :confirmation_sent_at, comment: '登録確認要求日時'
      t.string   :unconfirmed_email,    comment: '未確認メールアドレス' # Only if using reconfirmable

      ## Omniauthable
      t.string   :twitter_uid,  unique: true, comment: 'TwitterアカウントUID'
      t.string   :facebook_uid, unique: true, comment: 'FacebookアカウントUID'
      t.string   :google_uid,   unique: true, comment: 'GoogleアカウントUID'

      ## Lockable
      t.integer  :failed_attempts,  default: 0, null: false, comment: '認証失敗回数' # Only if lock strategy is :failed_attempts
      t.string   :unlock_token,     comment: 'アカウントロック解除トークン' # Only if unlock strategy is :email or :both
      t.datetime :locked_at,        comment: 'アカウントロック日時'

      ## t.attachment :image
      t.string   :image_file_name,    comment: '画像ファイル名'
      t.string   :image_content_type, comment: '画像MIMEタイプ'
      t.integer  :image_file_size,    comment: '画像ファイルサイズ'
      t.datetime :image_updated_at,   comment: '画像更新日時'

      t.text     :bio,    comment: '自己紹介'
      t.text     :note,   comment: 'メモ'

      t.datetime :created_at, null: false, comment: '作成日時'
      t.datetime :updated_at, null: false, comment: '更新日時'
    end
    add_index :users, :key,                  unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :email
    add_index :users, :name
    add_index :users, :created_at
    add_index :users, :updated_at

    create_table :roles, comment: 'ロールマスタ' do |t|
      t.string    :code,        null: false, comment: 'コード'
      t.string    :name,        null: false, default: '', comment: '名称'
      t.integer   :sort,        comment: '並び順'
      t.datetime :created_at,   null: false, comment: '作成日時'
      t.datetime :updated_at,   null: false, comment: '更新日時'
    end
    add_index :roles, :code, unique: true
    add_index :roles, :created_at
    add_index :roles, :updated_at

    create_table :users_roles, comment: 'ユーザー：ロール' do |t|
      t.integer :user_id, null: false, comment: 'ユーザーID'
      t.integer :role_id, null: false, comment: 'ロールID'
    end
    add_index :users_roles, [:user_id, :role_id], unique: true
    add_foreign_key :users_roles, :user_id
    add_foreign_key :users_roles, :role_id

    Role.new(
      sort: 1,
      code: 'admin',
      name: 'Administrator'
    ).save(validate: false)

    admin = User.new(
      nick_name: 'Administrator',
      email: 'admin@example.com',
      password: 'adminadmin',
      confirmed_at: Time.now,
      role_ids: [Role.find_by(code: 'admin').id]
    )
    admin.generate_key
    admin.save(validate: false)

    create_table :sessions, comment: 'セッションデータ' do |t|
      t.string    :session_id,  null: false, comment: 'セッションID'
      t.text      :data,        comment: 'データ'
      t.datetime  :created_at,  null: false, comment: '作成日時'
      t.datetime  :updated_at,  null: false, comment: '更新日時'
    end
    add_index :sessions, :session_id, unique: true
    add_index :sessions, :created_at
    add_index :sessions, :updated_at

  end

end
