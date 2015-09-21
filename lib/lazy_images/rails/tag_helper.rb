require 'lazy_images/rails/placeholder'

module LazyImages
  module Rails
    mattr_accessor :placeholder

    module TagHelper
      def self.included(base)
        base.alias_method_chain :image_tag, :lazy_images
      end

      def image_tag_with_lazy_images(source, options={})
        options.merge!(
          class: "#{options[:class]} rli-image",
          src: path_to_image(source)
        )

        placeholder = LazyImages::Rails::Placeholder.new(
          LazyImages::Rails.placeholder, options
        )

        content_tag(:div, class: 'rli-wrapper') do
          placeholder.to_s.html_safe +
            image_tag_without_lazy_images(source, options)
        end
      end
    end
  end
end
