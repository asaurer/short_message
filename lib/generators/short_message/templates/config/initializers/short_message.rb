ShortMessage.configure do |config|
  config.gateway_server = "www1.q-x.ch"
  config.gateway_port = "443"
  
  config.send_file_path = "/app/sms/gw1/cust/send.php"
  config.account_functions_path = "/app/sms/gw1/cust/accfunc.php"  
  
  # enter your details received from provider here
  config.user_id = ""
  config.ccu_id = ""
  config.id_string = ""
      
  config.default_reload_amount = 1000
  
  config.default_mail_sender = "webmaster@your-domain.com"
  config.reload_notification_email = "webmaster@your-domain.com"
  config.voucher_notification_email = "give-me-money@your-domain.com"
end