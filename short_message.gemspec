$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "short_message/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "short_message"
  s.version     = ShortMessage::VERSION
  s.authors     = ["Andi Saurer"]
  s.email       = ["andi@saurer.me"]
  s.homepage    = "https://github.com/qinglong15/short_message"
  s.summary     = "Send short messages to a specific SMS Gateway"
  s.description = "Send short messages to a specific SMS Gateway"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "> 3.2.12"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "growl"
end
