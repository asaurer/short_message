# encoding: utf-8
module ConfigHelper
  def load_default_config
    ShortMessage.configure do |config|
      config.user_id = "1234"
      config.ccu_id = "1234"
      config.id_string = "123456789abcdefghijklmnopq"
      
      config.default_reload_amount = 1000
      config.reload_notification_email = "webmaster@your-domain.com"
      config.voucher_notification_email = "give-me-money@your-domain.com"
      config.default_mail_sender = "webmaster@your-domain.com"
    end
  end
end
