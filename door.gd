extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var d_x = 1

var point_1 = Vector3(-112,31.5,-12)
var point_2 = Vector3(-112,-260,-12)

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
	translation.x+=delta*d_x*speed
	if (translation.x < point_1.x) or (translation.x > point_2.x):
		d_x*=-1
		translation.x+=delta*d_x*speed
		wait_timer=2
