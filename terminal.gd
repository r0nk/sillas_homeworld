extends TextEdit

signal set_turret_status(active)

var file_system={"process":0,"devices":0,"hello.txt":"this is an example file that says hello world!"}

func command(cmd):
	write("\n")
	var args=cmd.split(" ")

	match args[0]:
		"list":
			for f in file_system.keys():
				write(f+"\n")
			return
		"read":
			if args[1] in file_system.keys():
				write(file_system[args[1]])
			else:
				write("file not found.\n")
			return
		"help":
			write("activate\ndeactivate\nexit")
			return
		"activate":
			emit_signal("set_turret_status",true)
			write("activating turrets...")
			return
		"deactivate":
			emit_signal("set_turret_status",false)
			write("deactivating turrets...")
			return
		"exit":
			write("logout")
			get_node("../../").logout();
			return
	$error_sfx.play()
	write("Command not found.")

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


func _ready():
	text=""
	rect_position=get_viewport().size/2 - rect_size/2
	write(PS1)
	pass

#TODO handle pipes
func write(s):
	insert_text_at_cursor(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
