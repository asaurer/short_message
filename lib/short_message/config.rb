require 'active_support/configurable'

module ShortMessage
  def self.configure(&block)
    yield @config ||= ShortMessage::Configuration.new
  end

  def self.config
    @config
  end

  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :gateway_server
    config_accessor :gateway_port
    config_accessor :send_file_path
    config_accessor :account_functions_path

    config_accessor :user
    config_accessor :password

    config_accessor :default_sms_sender
    config_accessor :default_reload_amount
    config_accessor :reload_notification_email
    config_accessor :admin_notification_email
    config_accessor :voucher_notification_email
    config_accessor :default_mail_sender

    def param_name
      config.param_name.respond_to?(:call) ? config.param_name.call : config.param_name
    end

    # define param_name writer
    writer, line = 'def param_name=(value); config.param_name = value; end', __LINE__
    singleton_class.class_eval writer, __FILE__, line
    class_eval writer, __FILE__, line
  end
end
