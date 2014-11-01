# == Schema Information
#
# Table name: users_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  role_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  fk__users_roles_user_id                   (user_id)
#  index_users_roles_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#

#= ユーザー：ロール

class UsersRole < ActiveRecord::Base

  belongs_to :user, touch: true
  belongs_to :role

end
