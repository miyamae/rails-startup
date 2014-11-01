class Initialize < ActiveRecord::Migration

  def change

    create_table(:users) do |t|
      t.string :key, null: false, index: { unique: true }
      t.string :name, null: false, default: '', index: true
      t.string :nick_name, null: false, default: ''

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Omniauthable
      # t.integer :uid, :limit => 8
      # t.string :provider

      t.string   :twitter_uid, unique: true
      t.string   :facebook_uid, unique: true
      t.string   :google_uid, unique: true

      ## Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.attachment :image
      t.text       :bio
      t.text       :note

      t.timestamps    index: true
    end

    add_index :users, :email
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true

    # 権限
    create_table :roles do |t|
      t.string    :code, null: false, index: { unique: true }
      t.string    :name, null: false, default: ''
      t.integer   :sort
      t.timestamps
    end

    # ユーザ：権限
    create_table :users_roles do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :role_id, null: false, foreign_key: true, index: { with: :user_id, unique: true }
    end

    Role.new(
      sort: 1,
      code: 'admin',
      name: '管理者'
    ).save(validate: false)

    admin = User.new(
      nick_name: '管理者',
      email: 'admin@example.com',
      password: 'adminadmin',
      confirmed_at: Time.now,
      role_ids: [Role.find_by(code: 'admin').id]
    )
    admin.generate_key
    admin.save(validate: false)

    # セッションストア
    create_table :sessions do |t|
      t.string    :session_id, null: false, foreign_key: false
      t.text      :data
      t.timestamps
    end
    add_index :sessions, :session_id, unique: true
    add_index :sessions, :updated_at

  end

end
