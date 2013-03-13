module ShortMessage
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copy ShortMessage configuration files"
      source_root File.expand_path('../templates', __FILE__)
      
      def copy_config
        template "config/initializers/short_message.rb"
        template "config/locales/short_message.de.yml"
        template "config/locales/short_message.en.yml"
      end
    end
  end
end
