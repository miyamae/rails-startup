class JpMailer < ActionMailer::Base
  default charset: 'iso-2022-jp'
  default from: 'dummy@example.com'
end