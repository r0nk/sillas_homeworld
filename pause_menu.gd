extends Popup

var cooldown = 0
func _ready():
	pass

func toggle_pause_game():
	get_tree().paused=!get_tree().paused;
	cooldown = 0.2
	if get_tree().paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()

func _process(delta):
	if(cooldown > 0):
		cooldown-=delta
		return
	if Input.is_action_pressed("pause"):
		toggle_pause_game()


