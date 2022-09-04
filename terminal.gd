extends TextEdit

signal set_turret_status(active)

var file_system={"process":0,"devices":0,"hello.txt":"this is an example file that says hello world!"}

func toggle_gate(gate):
	if(gate == "a"):
		print(get_tree().get_current_scene().get_node("gravset1").set_active(true))

func command(cmd):
	write("\n")
	var args=cmd.split(" ")

	match args[0].to_lower():
		"yuo": # alien for 'toggle'
			if(args.size()>1):
				write("dawext czyz: "+args[1]) #"toggling gate %s"
				toggle_gate(args[1])
			else:
				write("ufzo tjoju fli ") #"error, insufficent arguemnts"
			return
	$error_sfx.play()
	write("ufzo cle zeq") #"error, no command"

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
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_node("../../").logout();

func _ready():
	text=""
	rect_position=get_viewport().size/2 - rect_size/2
	write(PS1 + "yuo a\n")
	write(PS1)
	pass

#TODO handle pipes
func write(s):
	insert_text_at_cursor(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
