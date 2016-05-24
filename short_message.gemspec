$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "short_message/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "short_message"
  s.version     = ShortMessage::VERSION
  s.authors     = ["Andi Saurer"]
  s.email       = ["andreas.saurer@econ.uzh.ch"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ShortMessage."
  s.description = "TODO: Description of ShortMessage."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "mysql2"
end
