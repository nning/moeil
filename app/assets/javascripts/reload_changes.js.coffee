$ ->
  if $('h1').html() == 'Changes'
    setTimeout(->
      location.reload()
    , 120 * 1000)
