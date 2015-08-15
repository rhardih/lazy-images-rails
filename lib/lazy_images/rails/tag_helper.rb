module LazyImages
  module Rails
    module TagHelper
      def self.included(base)
        base.alias_method_chain :image_tag, :lazy_images
      end

      def image_tag_with_lazy_images(source, options={})
        src = path_to_image(source)
        data = { rli_image_src: src, rli_placeholder: true }

        content_tag(:div, data: data, class: 'rli-wrapper') do
          %(
          <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" class="rli-placeholder">
            <path class="moon" d="M832 288c0 53.020-42.98 96-96 96s-96-42.98-96-96 42.98-96 96-96 96 42.98 96 96z"></path>
            <path class="mountain" d="M896 832h-768v-128l224-384 256 320h64l224-192z"></path>
          </svg>
          ).html_safe + content_tag(:noscript) do
            options[:src] = src
            options[:class] = "#{options[:class]} rli-image"
            image_tag_without_lazy_images(source, options)
          end
        end
      end
    end
  end
end
