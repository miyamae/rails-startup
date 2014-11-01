class ContactMailer < JpMailer

  def contact(contact)
    @contact = contact
    mail to: ENV['email'],
      subject: "#{Const::PRODUCT}: 問い合わせ",
      from: ENV['email']
  end

end
