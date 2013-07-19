$ ->
  if $('h1').html() == 'Changes'
    setTimeout(->
      location.reload()
    , 10 * 1000)
