$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "short_message/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "short_message"
  s.version     = ShortMessage::VERSION
  s.authors     = ["Andi Saurer"]
  s.email       = ["andreas.saurer@econ.uzh.ch"]
  s.homepage    = "https://gitlab.switch.ch/econ-engineering/short_message"
  s.summary     = "Send short messages to a specific SMS Gateway"
  s.description = "Send short messages to a specific SMS Gateway"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "mysql2"
end
