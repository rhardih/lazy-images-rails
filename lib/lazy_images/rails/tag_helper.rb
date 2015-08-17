module LazyImages
  module Rails
    mattr_accessor :placeholder

    module TagHelper
      def self.included(base)
        base.alias_method_chain :image_tag, :lazy_images
      end

      def image_tag_with_lazy_images(source, options={})
        src = path_to_image(source)
        data = { rli_image_src: src, rli_placeholder: true }

        content_tag(:div, data: data, class: 'rli-wrapper') do
          LazyImages::Rails.placeholder.html_safe + content_tag(:noscript) do
            options[:src] = src
            options[:class] = "#{options[:class]} rli-image"
            image_tag_without_lazy_images(source, options)
          end
        end
      end
    end
  end
end
