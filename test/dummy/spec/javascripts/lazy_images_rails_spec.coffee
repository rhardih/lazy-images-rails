#= require lazy_images_rails

describe "RailsLazyImages", ->
  it "is defined", ->
    expect(LazyImagesRails).toBeDefined()

  describe "init()", ->
    fixture.set '<div data-rli-image-src="/foo.png" data-rli-placeholder="true" class="rli-wrapper">
      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" class="rli-placeholder"></svg>
      <noscript><img src="/foo.png" class="rli-image" alt="Foo"></noscript>
    </div>'

    beforeEach (done) ->
      LazyImagesRails.init(done)

    it "removes all placeholders", ->
      elements = document.querySelectorAll "div[data-rli-placeholder]"
      expect(elements.length).toBe(0)

    it "replaces placholders with images", ->
      expected = '<img src="/foo.png" class="rli-image" alt="Foo">'
      expect(fixture.el.innerHTML).toBe(expected)

    describe "with dimensions on placeholder", ->
      fixture.set '<div data-rli-image-src="/foo.png" data-rli-placeholder="true" class="rli-wrapper">
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" class="rli-placeholder" width="123" height="456"></svg>
        <noscript><img src="/foo.png" class="rli-image" alt="Foo" width="123" height="456"></noscript>
      </div>'

      beforeEach (done) ->
        LazyImagesRails.init(done)

      it "replaces images on page and preserves dimensions", ->
        expected = '<img src="/foo.png" class="rli-image" alt="Foo" width="123" height="456">'
        expect(fixture.el.innerHTML).toBe(expected)
