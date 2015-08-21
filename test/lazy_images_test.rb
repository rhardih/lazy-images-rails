require 'test_helper'

class LazyImagesTest < ActionView::TestCase
  test "truth" do
    assert_kind_of Module, LazyImages
  end

  test "image_tag outputs wrapped image with placeholder and noscript" do
    expected = fixture("_image_tag_output.html")

    assert_dom_equal(expected, image_tag('foo.png'))
  end

  private

  def fixture(name)
    File.read(File.expand_path("../fixtures/#{name}", __FILE__)).chop!
  end
end
