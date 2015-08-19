require 'test_helper'

class LazyImagesTest < ActionView::TestCase
  test "truth" do
    assert_kind_of Module, LazyImages
  end

  test "image_tag outputs wrapped image with placeholder and noscript" do
    expected = File.read(File.expand_path("../fixtures/_image_tag_output.html", __FILE__))

    assert_dom_equal(expected, image_tag('foo.png'))
  end
end
