# == Schema Information
#
# Table name: roles # ロールマスタ
#
#  id         :integer          not null, primary key # ロールマスタ
#  code       :string(255)      not null              # コード
#  name       :string(255)      default(""), not null # 名称
#  sort       :integer                                # 並び順
#  created_at :datetime         not null              # 作成日時
#  updated_at :datetime         not null              # 更新日時
#
# Indexes
#
#  index_roles_on_code  (code) UNIQUE
#

#= Role for users

class Role < ActiveRecord::Base

  default_scope { order sort: :asc }

  has_many :users_roles, dependent: :destroy
  has_many :users, through: :users_roles

  validates :code, presence: true
  validates :name, presence: true

end
