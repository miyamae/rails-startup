# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  code       :string(255)      not null
#  name       :string(255)      default(""), not null
#  sort       :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_roles_on_code  (code) UNIQUE
#

#= ロール

class Role < ActiveRecord::Base

  default_scope { order sort: :asc }

  has_many :users_roles, dependent: :destroy
  has_many :users, through: :users_roles

  validates :code, presence: true
  validates :name, presence: true

end
