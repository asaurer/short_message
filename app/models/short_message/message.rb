module ShortMessage
  class Message < ActiveRecord::Base
    def deliver
      self.sender = ShortMessage.config.default_sms_sender if self.sender.blank?

      unless self.recipient.blank? and self.text.blank?
        http = Net::HTTP.new(ShortMessage.config.gateway_server, ShortMessage.config.gateway_port)
        if ShortMessage.config.gateway_port == Net::HTTP.https_default_port()
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        response, data = http.post(ShortMessage.config.send_file_path, build_deliver_params_string)
        result_set = response.body.gsub("(","").gsub(")","").split(" ")
        response_code = result_set[0].to_i

        if response_code == 200 or response_code == 402
          if response_code == 402 and not ShortMessage.config.reload_notification_email.blank?
            ShortMessage::Mailer.payment_required_notification(self, response).deliver_now
          end

          self.message_key = result_set[2] unless result_set[2].blank?
          ActiveSupport::Notifications.instrument('short_message.delivered', options: { key: (result_set[2] unless result_set[2].blank?) })
          return self.save
        else
          ShortMessage::Mailer.error_notification(self, response).deliver_now unless ShortMessage.config.admin_notification_email.blank?
        end
      else
        return false
      end
    end

    def recharge
      raise "NOT YET IMPLEMENTED"
    end

    def status_text
      I18n.t("short_message.status.code_#{self.status_code}")
    end

    private
    def build_deliver_params_string
      params = []
      params << "user=#{ShortMessage.config.user}"
      params << "pass=#{ShortMessage.config.password}"
      params << "from=#{CGI.escape(self.sender)}"
      params << "to=#{CGI.escape(self.recipient)}"
      params << "text=#{CGI.escape(self.text)}"
      params.join("&")
    end

    def build_recharge_params_string amount
      raise "NOT YET IMPLEMENTED"
      # params = []
      # params << "user=#{ShortMessage.config.user}"
      # params << "password=#{ShortMessage.config.password}"
      # params << "amount=#{amount}"
      # params.join("&")
    end
  end
end
