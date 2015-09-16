class @LazyImagesRails
  @init: (all_replaced) ->
    replace_with_image = (placeholder) =>
      noscript = placeholder.querySelector('noscript')
      method = if 'innerText' in noscript then 'innerText' else 'textContent'
      content = noscript[method]

      tmp = document.createElement('div')
      tmp.innerHTML = content # will trigger download of image
      img = tmp.querySelector('img')
      # Race condition:
      # Event attachment happens after the download triggers above.
      # If image loads before getting here, the callback never runs.
      img.onload = =>
        placeholder.parentNode.replaceChild(img, placeholder)
        if all_replaced? && --@placeholder_count == 0
          all_replaced.call()

    placeholders = document.querySelectorAll('div[data-rli-placeholder]')
    @placeholder_count = placeholders.length

    for placeholder in placeholders
      replace_with_image placeholder
