# == Schema Information
#
# Table name: users_roles
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#  role_id :integer          not null
#
# Indexes
#
#  fk__users_roles_user_id                   (user_id)
#  index_users_roles_on_role_id_and_user_id  (role_id,user_id) UNIQUE
#

FactoryGirl.define do
  factory :users_role do
    role { Role.find_by(name: role) }
    user { User.find_by(name: user) }
  end
end
