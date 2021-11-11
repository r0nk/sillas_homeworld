extends Spatial

var time_passed = 0
var target_locked=false
var locked_time=0.0
var active = true

func set_turret_status(state):
	print(state)
	active=state

# Called when the node enters the scene tree for the first time.
func _ready():
	$target_get.pitch_scale=2.0+rand_range(-1.0,2.0)
	print($target_get.pitch_scale)
	$target_get.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		$gun/laser.spot_range=0
		$gun/laser/light.material.albedo_color=Color(0,1,0);
		return
	$gun/laser.spot_range=20
	$gun/laser/light.material.albedo_color=Color(1,0,0);
	time_passed+=delta;
	look_at(get_node("../player").translation ,Vector3.UP)
	if($gun/raycast.is_colliding()):
		if $gun/raycast.get_collider().is_in_group("player"):
			if not target_locked:
				$target_get.play()
			target_locked=true
			$gun/barrel.rotation.y+=delta*10
		else:
			target_locked=false
	if target_locked:
		locked_time+=delta
		if locked_time > 1.5:
			print("player is kill")
	else:
		locked_time=0
#	$gun.rotation.y=sin(time_passed)/5
	pass
