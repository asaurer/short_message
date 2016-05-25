ShortMessage.configure do |config|
  # Configuration example www.gtx-messaging.com
  config.gateway_server = "http.gtx-messaging.net"
  config.gateway_port = 443

  config.send_file_path = "smsc.php"
  # config.account_functions_path = ""

  # enter your details received from provider here
  config.user = ""
  config.password = ""

  # config.default_reload_amount = 1000

  config.default_mail_sender = "webmaster@your-domain.com"
  config.reload_notification_email = "webmaster@your-domain.com" # send a message if payment is required
  config.admin_notification_email = "webmaster@your-domain.com" # set nil to deactivate error mailing
  config.voucher_notification_email = "give-me-money@your-domain.com" # set nil to disable voucher mailing

  # set a default sms sender (used if no sender is present)
  # config.default_sms_sender = ""
end
