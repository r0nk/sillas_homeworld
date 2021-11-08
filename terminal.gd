extends TextEdit


func command(cmd):
	if cmd == "help":
		write("\nThis is a help line.")
	elif cmd == "exit":
		write("\nlogout")
		get_node("../../").logout();
	else:
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
	write(PS1)
	pass # Replace with function body.

func write(s):
	insert_text_at_cursor(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
