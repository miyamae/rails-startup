# == Schema Information
#
# Table name: users # ユーザーマスタ
#
#  id                     :integer          not null, primary key # ユーザーマスタ
#  key                    :string(255)      not null              # 固有キー
#  name                   :string(255)      default(""), not null # ユーザー名
#  nick_name              :string(255)      default(""), not null # ニックネーム
#  email                  :string(255)      default(""), not null # メールアドレス
#  encrypted_password     :string(255)      default(""), not null # パスワード(ハッシュ値)
#  reset_password_token   :string(255)                            # パスワードリセットトークン
#  reset_password_sent_at :datetime                               # パスワードリセット要求日時
#  remember_created_at    :datetime                               # 次回自動指定でのログイン日時
#  sign_in_count          :integer          default(0), not null  # ログイン回数
#  current_sign_in_at     :datetime                               # 今回ログイン日時
#  last_sign_in_at        :datetime                               # 前回ログイン日時
#  current_sign_in_ip     :string(255)                            # 今回アクセス元IP
#  last_sign_in_ip        :string(255)                            # 前回アクセス元IP
#  confirmation_token     :string(255)                            # 登録確認トークン
#  confirmed_at           :datetime                               # 登録確認済み日時
#  confirmation_sent_at   :datetime                               # 登録確認要求日時
#  unconfirmed_email      :string(255)                            # 未確認メールアドレス
#  twitter_uid            :string(255)                            # TwitterアカウントUID
#  facebook_uid           :string(255)                            # FacebookアカウントUID
#  google_uid             :string(255)                            # GoogleアカウントUID
#  failed_attempts        :integer          default(0), not null  # 認証失敗回数
#  unlock_token           :string(255)                            # アカウントロック解除トークン
#  locked_at              :datetime                               # アカウントロック日時
#  image_file_name        :string(255)                            # 画像ファイル名
#  image_content_type     :string(255)                            # 画像MIMEタイプ
#  image_file_size        :integer                                # 画像ファイルサイズ
#  image_updated_at       :datetime                               # 画像更新日時
#  bio                    :text                                   # 自己紹介
#  note                   :text                                   # メモ
#  created_at             :datetime         not null              # 作成日時
#  updated_at             :datetime         not null              # 更新日時
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_created_at            (created_at)
#  index_users_on_email                 (email)
#  index_users_on_key                   (key) UNIQUE
#  index_users_on_name                  (name)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_updated_at            (updated_at)
#

FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "user#{n}" }
    email { "#{name}@example.com" }
    password { 'password' }
    confirmed_at { Time.now }
  end
end
