extends RichTextLabel


var timer=0

func print(string):
	text+=string
	timer=3

func _process(delta):
	if timer > 0:
		if timer < 1:
			percent_visible=timer
		timer-=delta
		visible=true
	else:
		visible=false
