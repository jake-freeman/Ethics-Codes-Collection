$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ecc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ecc"
  s.version     = Ecc::VERSION
  s.authors     = [""]
  s.email       = ["ayoung11@hawk.iit.edu"]
  s.homepage    = ""
  s.summary     = ": Summary of Ecc."
  s.description = ": Description of Ecc."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
