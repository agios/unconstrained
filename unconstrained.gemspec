$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "unconstrained/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unconstrained"
  s.version     = Unconstrained::VERSION
  s.authors     = ["Alexandros Giouzenis"]
  s.email       = ["alexandrosg@gmail.com"]
  s.homepage    = "https://github.com/agios/unconstrained"
  s.summary     = "A gem that converts Active Record foreign key exceptions."
  s.description = "This gem converts the foreign key exceptions raised by the database into Active Model errors that can be displayed by an application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = "~> 2.0"
  s.add_dependency "rails", "~> 5.0"

  s.add_development_dependency "pg", "~> 0"
end
