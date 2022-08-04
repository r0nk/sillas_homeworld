extends Button

func button_pressed():
	get_tree().paused=false
	get_tree().reload_current_scene();

func _ready():
	pass
