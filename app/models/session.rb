# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  session_id :string(255)      not null
#  data       :text
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
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
