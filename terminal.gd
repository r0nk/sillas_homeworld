extends TextEdit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _input(event):
	if(event.as_text()=="Enter"):
		readonly=true
		write("$ ")
		readonly=false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func write(s):
	var c = cursor_get_column()
	var l = cursor_get_line()
	text+=s
	cursor_set_column(c+s.length())
	cursor_set_line(l+1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
