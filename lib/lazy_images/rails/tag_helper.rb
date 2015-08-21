require 'nokogiri'

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
        placeholder = LazyImages::Rails.placeholder.dup

        if options[:size]
          # N. B. extract_dimensions is a private method from
          # actionview/lib/action_view/helpers/asset_tag_helper.rb
          # beware of breakage
          options[:width], options[:height] = extract_dimensions(options.delete(:size))

          fragment = Nokogiri::XML::DocumentFragment.parse(placeholder)
          fragment.first_element_child.set_attribute('width', options[:width])
          fragment.first_element_child.set_attribute('height', options[:height])

          placeholder = fragment.to_s
        end

        content_tag(:div, data: data, class: 'rli-wrapper') do
          placeholder.html_safe + content_tag(:noscript) do
            options[:src] = src
            options[:class] = "#{options[:class]} rli-image"
            image_tag_without_lazy_images(source, options)
          end
        end
      end
    end
  end
end
