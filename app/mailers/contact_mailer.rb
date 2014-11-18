class ContactMailer < JpMailer

  def contact(contact)
    @contact = contact
    mail to: ENV['email'],
      subject: "[Contact] #{Const::PRODUCT}",
      from: ENV['email']
  end

end
