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
#  index_users_roles_on_user_id_and_role_id  (user_id,role_id) UNIQUE
#

#= Relationsips for User:Role

class UsersRole < ActiveRecord::Base

  belongs_to :user, touch: true
  belongs_to :role

end
