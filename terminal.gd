extends TextEdit

signal set_turret_status(active)

func command(cmd):
	if cmd == "help":
		write("\nThis is a help line.")
	elif cmd == "activate":
		emit_signal("set_turret_status",true)
		write("\nactivating turrets...")
	elif cmd == "deactivate":
		emit_signal("set_turret_status",false)
		write("\ndeactivating turrets...")
	elif cmd == "exit":
		write("\nlogout")
		get_node("../../").logout();
	else:
		$error_sfx.play()
		write("\nCommand not found.")

var PS1 = "$ "
func _input(event):
	if not visible:
		return
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			if (get_line(cursor_get_line()).length() > PS1.length()):
				command(get_line(cursor_get_line()).trim_prefix(PS1))
			write("\n")
			write(PS1)
			get_tree().set_input_as_handled()
		if event.pressed and event.scancode == KEY_BACKSPACE:
			if (get_line(cursor_get_line()).length() <= PS1.length()):
				get_tree().set_input_as_handled() #don't go further back then PS1


# Called when the node enters the scene tree for the first time.
func _ready():
	text=""
	rect_position=get_viewport().size/2 - rect_size/2
	write(PS1)
	pass # Replace with function body.

func write(s):
	insert_text_at_cursor(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
