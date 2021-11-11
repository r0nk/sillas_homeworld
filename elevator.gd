extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var d_y = 1

var point_1 = Vector3(-32.0,-1.4,-19.5)
var point_2 = Vector3(-32.0,31.7,-19.5)

var wait_timer = 2
var speed=5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(wait_timer > 0):
		wait_timer-=delta
		return
	translation.y+=delta*d_y*speed
	if (translation.y < point_1.y) or (translation.y > point_2.y):
		d_y*=-1
		translation.y+=delta*d_y*speed
		wait_timer=2
