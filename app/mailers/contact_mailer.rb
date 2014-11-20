class ContactMailer < JpMailer

  def contact(contact)
    @contact = contact
    mail to: ENV['email'] || 'dummy@example.com',
      subject: "[Contact] #{Const::PRODUCT}",
      from: ENV['email'] || 'no-reply@example.com'
  end

end
