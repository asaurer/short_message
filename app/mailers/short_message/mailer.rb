module ShortMessage
  class Mailer < ApplicationMailer
    def error_notification message, response
      mail to: ShortMessage.config.admin_notification_email, subject: "Error delivering SMS to #{message.recipient}", body: "SMS from #{message.sender} to #{message.recipient} could not be sent!\r\n\r\nResponse: #{response.to_yaml}"
    end

    def payment_required_notification
      mail to: ShortMessage.config.reload_notification_email, subject: "SMS Gateway requires payment", body: "Your SMS Gateway API #{ShortMessage.config.gateway_server} requires payment!"
    end
  end
end
