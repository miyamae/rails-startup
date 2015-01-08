#= Contact form

class Contact
  include ActiveAttr::Model

  attr_accessor :name, :company, :email, :phone, :body

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true
  validates :body, presence: true, length: { maximum: 10000 }

  def sendmail
    ContactMailer.contact(self).deliver_now
  end

end
