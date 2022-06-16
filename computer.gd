extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var user

# Called when the node enters the scene tree for the first time.
func _ready():
	$ambience.play()
	pass # Replace with function body.

func interact(p):
	$logon_sfx.play()
	user=p
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$vp/terminal.visible=true
	$vp/terminal.grab_focus()
	user.move_locked=true


func logout():
	$logoff_sfx.play()
	if not user:
		print("logout called with no user at terminal");
		return
	user.move_locked=false
	$vp/terminal.visible=false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if not $ambience.playing:
		$ambience.play()
	pass
