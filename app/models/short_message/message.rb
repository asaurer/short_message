require "net/http"

module ShortMessage
  class Message < ActiveRecord::Base
    attr_accessible :message_key, :recipient, :sender, :status_code, :text

    def status_text
      I18n.t("short_message.status.code_#{self.status_code}")
    end

    def deliver
      self.sender = ShortMessage.config.default_sms_sender if self.sender.blank?

      unless self.recipient.blank? and self.text.blank?
        http = Net::HTTP.new(ShortMessage.config.gateway_server, ShortMessage.config.gateway_port)
        if ShortMessage.config.gateway_port == Net::HTTP.https_default_port()
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        response, data = http.post(ShortMessage.config.send_file_path, build_deliver_params_string)

        if response.code == "200"
          # returns something like 0:200: OK (<mobilenumber>:<msgid>)
          result_set = response.body.gsub("(","").gsub(")","").split(":")
          self.status_code = result_set[0].to_i
          self.message_key = result_set[3] unless result_set[3].blank?

          if self.status_code == 3 and ShortMessage.config.default_reload_amount > 0
            if self.recharge
              self.deliver
            else
              self.status_code = 99
              return false
            end
          end

          self.save
          true
        else
          Mailer.error_notification(self, response).deliver unless ShortMessage.config.admin_notification_email.blank?
          false
        end
      end
    end

    def recharge amount = ShortMessage.config.default_reload_amount
      unless ShortMessage.config.account_functions_path.blank?
        http = Net::HTTP.new(ShortMessage.config.gateway_server)
        response, body = http.post(ShortMessage.config.account_functions_path, build_recharge_params_string(amount))

        if response.code == "200"
          # returns something like 0:Successful
          result_set = response.body.split(":")

          if result_set[0].to_i == 0
            logger.info "SMS account successfully charged with #{amount} sms."
            Mailer.recharge_notification(amount).deliver unless ShortMessage.config.reload_notification_email.blank?
            Mailer.voucher_notification(amount).deliver unless ShortMessage.config.voucher_notification_email.blank?
            true
          else
            logger.warn "SMS account could not be recharged with #{amount} sms. Error: #{body}"
            Mailer.recharge_failed_notification(amount, body).deliver unless ShortMessage.config.reload_notification_email.blank?
            false
          end
        else
          "#{response.code} #{response.message}"
        end
      end
    end

    private
    def build_deliver_params_string
      params = []
      params << "UserID=#{ShortMessage.config.user_id}"
      params << "CCUID=#{ShortMessage.config.ccu_id}"
      params << "ID=#{ShortMessage.config.id_string}"
      params << "sender=#{CGI.escape(self.sender)}"
      params << "receipient=#{CGI.escape(self.recipient)}"
      params << "message=#{CGI.escape(self.text)}"
      params << "utf-8=1"
      params.join("&")
    end

    def build_recharge_params_string amount
      params = []
      params << "UserIDFS=#{ShortMessage.config.user_id}"
      params << "CCUID=#{ShortMessage.config.ccu_id}"
      params << "pay=1"
      params << "amount=#{amount}"
      params << "idstring=#{ShortMessage.config.id_string}"
      params.join("&")
    end
  end
end
