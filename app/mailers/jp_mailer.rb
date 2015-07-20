class JpMailer < ActionMailer::Base
  default charset: 'iso-2022-jp'
  default from: ENV['email'] || 'dummy@example.com'
end