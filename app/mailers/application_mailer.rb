class ApplicationMailer < ActionMailer::Base
  default from: ShortMessage.config.default_mail_sender
end
