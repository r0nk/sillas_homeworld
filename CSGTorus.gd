extends CSGTorus

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	inner_radius = get_parent().radius + 0.01

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	rotate_y(-0.3 * delta)
