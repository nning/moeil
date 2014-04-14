to_string = (val, unit) ->
  '~ ' + parseFloat(val).toFixed(2) + ' ' + unit

size_string = (val) ->
  m = val / 1024
  g = m / 1024
  t = g / 1024

  str = ''
  str = 'unlimited'         if val == '0'
  str = to_string(m, 'MiB') if Math.round(m) > 0
  str = to_string(g, 'GiB') if Math.round(g) > 0
  str = to_string(t, 'TiB') if Math.round(t) > 0

  str

update_size = (c, val) ->
  hb = c.find('span.help-block')
  ms = hb.find('span.size')

  str = size_string(val)

  if ms.length
    ms.html(str)
  else
    hb.append(' <span class="size">' + str + '</span>')

$ ->
  c = $('div.mailbox_quota')

  if c.length
    i = c.find('input#mailbox_quota')
    
    i.keyup ->
      update_size(c, this.value)

    update_size(c, i[0].value)
