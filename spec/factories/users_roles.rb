# == Schema Information
#
# Table name: users_roles # ユーザー：ロール
#
#  id      :integer          not null, primary key # ユーザー：ロール
#  user_id :integer          not null              # ユーザーID
#  role_id :integer          not null              # ロールID
#
# Indexes
#
#  index_users_roles_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#  index_users_roles_on_user_id_and_role_id  (user_id,role_id) UNIQUE
#

FactoryGirl.define do
  factory :users_role do
    role { Role.find_by(name: role) }
    user { User.find_by(name: user) }
  end
end
