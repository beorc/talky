$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "talky/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "talky"
  s.version     = Talky::VERSION
  s.authors     = ["Yury Kotov"]
  s.email       = ["bairkan@gmail.com"]
  s.summary     = "sitemplate_core-#{s.version}"
  s.description = "Very simple forum functionality."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_dependency "cancan"
  s.add_dependency 'rails_autolink'
  s.add_dependency 'simple_form'
  s.add_dependency 'responders'
end
