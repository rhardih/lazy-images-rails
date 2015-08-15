require 'rails/engine'
require 'lazy_images/rails/tag_helper'

module LazyImages
  module Rails
    class Engine < ::Rails::Engine
      initializer :lazy_images_rails do
        ActionView::Helpers::AssetTagHelper.module_eval do
          include TagHelper
        end
      end
    end
  end
end
