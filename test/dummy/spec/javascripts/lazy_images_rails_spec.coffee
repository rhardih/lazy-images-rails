#= require lazy_images_rails

describe "RailsLazyImages", ->
  it "is defined", ->
    expect(LazyImagesRails).toBeDefined()

  describe "init()", ->
    fixture.set '<div data-rli-image-src="/foo.png" data-rli-placeholder="true" class="rli-wrapper">
      <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" class="rli-placeholder"></svg>
    </div>'

    beforeEach (done) ->
      LazyImagesRails.init(done)

    it "removes all placeholders", ->
      elements = document.querySelectorAll "div[data-rli-placeholder]"
      expect(elements.length).toBe(0)

    it "replaces placholders with images", ->
      expect(fixture.el.innerHTML).toBe('<img src="/foo.png">')

    describe "with dimensions on placeholder", ->
      fixture.set '<div data-rli-image-src="/foo.png" data-rli-placeholder="true" class="rli-wrapper">
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024" class="rli-placeholder" width="123" height="456"></svg>
      </div>'

      beforeEach (done) ->
        LazyImagesRails.init(done)

      it "replaces images on page and preserves dimensions", ->
        expect(fixture.el.innerHTML).toBe('<img width="123" height="456" src="/foo.png">')
