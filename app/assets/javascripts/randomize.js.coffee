$ ->
	$("a.randomize").click ->
		text = ""
		possible = "abcdefghijklmnopqrstuvwxyz"

		for i in [0..5]
			text += possible.charAt Math.floor(Math.random() * possible.length)

		$("input.randomize").val text
