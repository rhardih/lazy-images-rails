$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lazy_images/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lazy_images-rails"
  s.version     = LazyImages::Rails::VERSION
  s.authors     = ["René Hansen"]
  s.email       = ["renehh@gmail.com"]
  s.homepage    = "https://github.com/rhardih/lazy-images-rails"
  s.summary     = "Lazy loaded images with placeholders and noscript fallback"
  s.description = "lazy-images-rails is a rails plugin that augments the " \
    "standard image_tag helper to provide instant placeholder images while " \
    "the actual image is being lazy loaded. A noscript fallback is provided " \
    "along with the placeholder for non-js browsers."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "bump", "~> 0.5.2"
end
