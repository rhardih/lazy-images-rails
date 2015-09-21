require 'nokogiri'

module LazyImages
  module Rails
    class Placeholder
      include ActionView::Helpers::AssetTagHelper

      attr_reader :svg
      attr_reader :options

      def initialize(svg, options)
        @svg = svg
        @options = options
      end

      def to_s
        if options[:size]
          # N. B. extract_dimensions is a private method from
          # actionview/lib/action_view/helpers/asset_tag_helper.rb
          # beware of breakage
          options[:width], options[:height] =
            extract_dimensions(options.delete(:size))

          fragment = Nokogiri::XML::DocumentFragment.parse(svg)
          fragment.first_element_child['width'] = options[:width]
          fragment.first_element_child['height'] = options[:height]

          fragment.to_s
        else
          svg
        end
      end
    end
  end
end
