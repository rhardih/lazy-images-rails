# lazy-images-rails

lazy-images-rails is a rails plugin that augments the standard image_tag helper to provide instant placeholder images while the actual image is being lazy loaded. A noscript fallback is provided along with the placeholder for non-js browsers.

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
