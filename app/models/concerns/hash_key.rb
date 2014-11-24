#= Generate unique key (Model#key)

module HashKey
  extend ActiveSupport::Concern

  included do
    before_validation :generate_key
    validates :key, presence: true
  end

  def generate_key
    len = 8
    return if self.key.present?
    chars = [('0'..'9'),('a'..'z'),('A'..'Z')].map{|c| c.to_a }.flatten
    begin
      key = (0..len-1).map { chars[rand(chars.length)] }.join
    end until self.class.where(key: key).blank?
    self.key = key
  end

end
