# == Schema Information
#
# Table name: sessions # セッションデータ
#
#  id         :integer          not null, primary key # セッションデータ
#  session_id :string(255)      not null              # セッションID
#  data       :text                                   # データ
#  created_at :datetime         not null              # 作成日時
#  updated_at :datetime         not null              # 更新日時
#
# Indexes
#
#  index_sessions_on_created_at  (created_at)
#  index_sessions_on_session_id  (session_id) UNIQUE
#  index_sessions_on_updated_at  (updated_at)
#

#= Session

class Session < ActiveRecord::Base

  # Session Expiry
  def self.sweep(updated: 5.hour, created: 5.days)
    if updated.is_a?(String)
      updated = updated.split.inject { |count, unit| count.to_i.send(unit) }
    end
    if created.is_a?(String)
      created = created.split.inject { |count, unit| count.to_i.send(unit) }
    end
    delete_all "updated_at < '#{updated.ago.to_s(:db)}' OR created_at < '#{created.ago.to_s(:db)}'"
  end

end
