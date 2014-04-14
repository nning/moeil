update = ->
  table = $('table.changes')
  o = table.find('tr.version:first')

  uri = table.data('uri') + '?since=' + o.data('id')

  $.get uri, (data) ->
    unless data == ' '
      table.find('tbody').prepend(data)

      n = table.find('tr.version:first')
      n.hide()
      n.fadeIn()

      table.find('tr.version:last').remove()

  enqueue()

enqueue = ->
  setTimeout update, 10000

$ ->
  if $('table.changes').length && !document.URL.contains('?page=')
    enqueue()
