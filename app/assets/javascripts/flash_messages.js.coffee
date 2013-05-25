$ ->
  messages = $(".alert")
  timeout = null
  
  close = (message) ->
    message.fadeOut()

  messages.hover ->
    if timeout
      window.clearTimeout timeout
      timeout = null

  messages.each ->
    flash = $(this).closest(".alert")
    words = flash.text().split(" ").length
    delay = (if words < 20 then 3 else words / 4)
    timeout = window.setTimeout(->
      close flash
    , delay * 1000)
