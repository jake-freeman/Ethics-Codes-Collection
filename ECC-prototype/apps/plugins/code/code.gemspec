$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "code/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "code"
  s.version     = Code::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = ": Summary of Code."
  s.description = ": Description of Code."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
