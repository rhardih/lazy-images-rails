class @LazyImagesRails
  @init: (all_replaced) ->
    replace_with_image = (placeholder) =>
      svg = placeholder.querySelector('svg')

      width = svg.attributes.width
      height = svg.attributes.height
      img = null

      if width? && height?
        img = new Image(parseInt(width.value, 10), parseInt(height.value, 10))
      else
        img = new Image()

      img.onload = =>
        placeholder.parentNode.replaceChild(img, placeholder)
        if all_replaced? && --@placeholder_count == 0
          all_replaced.call()

      img.src = placeholder.dataset.rliImageSrc

    placeholders = document.querySelectorAll('div[data-rli-placeholder]')
    @placeholder_count = placeholders.length

    for placeholder in placeholders
      replace_with_image placeholder
