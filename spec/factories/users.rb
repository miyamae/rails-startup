# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  key                    :string(255)      not null
#  name                   :string(255)      default(""), not null
#  nick_name              :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  twitter_uid            :string(255)
#  facebook_uid           :string(255)
#  google_uid             :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  image_file_name        :string(255)
#  image_content_type     :string(255)
#  image_file_size        :integer
#  image_updated_at       :datetime
#  bio                    :text
#  note                   :text
#  created_at             :datetime
#  updated_at             :datetime
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
    sequence(:name) {|n| "factory-user#{n}" }
    key { name }
    email { "#{name}@example.com" }
    password { 'password' }
    confirmed_at { Time.now }
  end
end
