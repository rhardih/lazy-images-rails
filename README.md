# lazy-images-rails

lazy-images-rails is a Rails plugin that augments the standard [`image_tag`](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-image_tag) helper to provide instant placeholders for images while the actual image is being loaded.

### Why?

Due to the asynchronous nature of images in web pages, page content is often rendered a long time ahead of images. In many cases this leads to content *jumping* downwards once an image above it has been loaded.

This is very annoying when you've found a thing to click/tap on, and just before you do, it moves out of the way. Especially when it causes a misclick/tap on something unentended.

This problem can be solved in many ways, but the solution provided by this plugin, is to simply use a placeholder until the real image is loaded.

### How?

Instead of rendering a bare `<img />` tag, the Rails [`image_tag`](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-image_tag) helper renders an SVG placeholder with the relevant data for the image instead. This placeholder takes up the same space as it's constituent image.

Once the DOM is ready, the page is scanned for placeholders and each one is then replaced by it's image.

In case of non-js browsers, a noscript fallback is provided with the placeholder.

## Usage

Include the supplied assets in the respective manifests, `application.js`:

```javascript
//= require lazy_images_rails
```

And `application.css`

```css
*= require lazy_images_rails
```

Add an image in a view, `index.html.erb`:

```erb
<%= image_tag 'foo.png' %>
```

And then trigger the lazy-load by initializing the client side of things on DOM loaded, e.g.:

```javascript
yourDomReadyFunction(function() {
  LazyImagesRails.init();
});
```

In case an image needs to be inserted without a placeholder, since the `image_tag` helper has been aliased, accessing the unmodified helper is done with the suffix:

```erb
<%= image_tag_without_lazy_images 'foo.png' %>
```

---

### A note about non-square images

Since the image ratio of square images are all the same, by default the placeholder can be used without further ado to take up the same space as the square image it replaces.

If an image however, is not square, it becomes necessary to provide the dimensions explicitly.

The [`image_tag`](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-image_tag) helper already supports this through the `size` attribute:

```erb
image_tag('foo.png', size: "123x456")
```

So setting this attribute will affect the placeholder as well and set width and height accordingly in the same manner.


## Styling the placeholder

The default [placeholder image](https://github.com/rhardih/lazy-images-rails/blob/master/app/assets/images/placeholder.svg) is a simple graphic of a mountain and a moon. Both have been supplied with targetable classes for individual styling. Create a custom rule with these classes, e.g. (scss):

```css
.rli-wrapper {
  .rli-placeholder {
    background: #fff;

    .moon, .mountain {
      fill: #ddd;
    }
  }
}
```

And the constituent paths in the the svg image will be styled accordingly.

## Using custom svg as placeholder

The placeholder is stored as a string value in `LazyImages::Rails.placeholder`, so in order to overwrite the default, create an initializer and set it accordingly, e.g. `config/initializers/lazy_images-rails.rb`:

```ruby
custom_placeholder = File.read("#{Rails.root}/app/assets/images/custom.svg")
LazyImages::Rails.placeholder = custom_placeholder
```

Here assuming you have placed your custom placeholder in `app/assets/images/custom.svg`.


## Testing

### Ruby tests

```bash
rake test
```

### Clientside tests

lazy-images-rails uses teaspoon for testing the clientside javascript:

```bash
cd test/dummy && rake teaspoon
```

Alternatively it can run directly in the browser, by starting the dummy app and visiting the test harness page [http://localhost:3000/teaspoon](http://localhost:3000/teaspoon):

```bash
cd test/dummy && bin/rails s
```

## License

[MIT-LICENSE](https://github.com/rhardih/lazy-images-rails/blob/master/MIT-LICENSE) | http://rhardih.mit-license.org
