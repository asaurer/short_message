module ShortMessage
  class Engine < ::Rails::Engine
    isolate_namespace ShortMessage

    initializer "short_message.migrate_database" do |app|
      Rails.application.config.paths['db/migrate'] << paths["db/migrate"].expanded.join
    end

    config.generators do |g|
      g.test_framework false
      g.assets false
      g.helper false
    end
  end
end
