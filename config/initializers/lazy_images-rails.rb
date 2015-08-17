gem_path = File.expand_path("../../..", __FILE__)
placeholder_path = "#{gem_path}/app/assets/images/placeholder.svg"
LazyImages::Rails.placeholder ||= File.read(placeholder_path)
