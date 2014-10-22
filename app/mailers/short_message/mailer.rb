module ShortMessage
  class Mailer < ActionMailer::Base
    default from: ShortMessage.config.default_mail_sender

    def recharge_notification amount
      mail to: ShortMessage.config.reload_notification_email, :subject => "SMS credit recharged", :body => "Your SMS Account has automatically been recharged with #{amount} sms."
    end

    def voucher_notification amount
      mail :to => ShortMessage.config.voucher_notification_email, :subject => "SMS credit recharged, please create a voucher", :body => "Please add a voucher:\r\nCustomer: #{ShortMessage.config.user_id}\r\nAmount: #{amount} sms\r\n\r\nThank you!"
    end

    def recharge_failed_notification amount, message
      mail :to => ShortMessage.config.reload_notification_email, :subject => "SMS credit recharge failed", :body =>"SMS account could not be recharged with #{amount} sms. Error: #{body}"
    end

    def error_notification message, response
      mail :to => ShortMessage.config.reload_notification_email, :subject => "Error delivering SMS to #{message.recipient}", :body =>"SMS from #{message.sender} to #{message.recipient} could not be sent!\r\n\r\nResponse: #{response.to_yaml}"
    end
  end
end
