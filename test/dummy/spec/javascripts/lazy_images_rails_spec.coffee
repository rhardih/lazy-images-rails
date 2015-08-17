#= require lazy_images_rails

describe "RailsLazyImages", ->
  fixture.set '<div data-rli-image-src="/foo.png" data-rli-placeholder="true" class="rli-wrapper">
  ...
  </div>'

  it "is defined", ->
    expect(LazyImagesRails).toBeDefined()

  describe "init()", ->
    beforeEach (done) ->
      LazyImagesRails.init(done)

    it "replaces images on page", ->
      elements = document.querySelectorAll "div[data-rli-placeholder]"
      expect(elements.length).toBe(0)

      expect(fixture.el.innerHTML).toBe('<img src="/foo.png">')
