extends KinematicBody

var input_direction = Vector3()
var velocity = Vector3(0,0.001,0)
var gravity_vector = Vector3()
var health = 100
#probably a better way of doing this but yolo lmao
var is_player = true
var dead = false
var scrap = 0

var jumps=0
var extra_jumps=1
var power=0

var weapon_array = [[0,1]]

signal player_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#if not $camera/gun.gun_already_visible():

func _input(event):
	if event is InputEventMouseMotion:
		$camera.rotation_degrees.x=clamp($camera.rotation_degrees.x-event.relative.y*0.2,-90,90)
		$camera.rotation_degrees.y-=event.relative.x*0.2

func get_aim():
	return -$camera.transform.basis.z

func process_interactibles():
	if $camera/interact_cast.is_colliding():
		var body = $camera/interact_cast.get_collider()
		if body.is_in_group("interactibles"):
			$camera/HUD/undercross.text="Press [G] to Interact."
			if body.get("cost") and body.cost > 0:
				$camera/HUD/undercross.text="Pay $" + str(body.cost) + " to interact."
				if body.cost > scrap:
					$camera/HUD/undercross.text="Not enough scrap, it costs $" + str(body.cost)
			if Input.is_action_pressed("interact"):
				body.interact(get_node("."))
	else:
		$camera/HUD/undercross.text=""

func process_input(delta):

	process_interactibles()
	input_direction = Vector3()

	if Input.is_action_pressed("movement_forward"):
		input_direction.z-=1
	if Input.is_action_pressed("movement_backward"):
		input_direction.z+=1
	if Input.is_action_pressed("movement_left"):
		input_direction.x-=1
	if Input.is_action_pressed("movement_right"):
		input_direction.x+=1


	if is_on_floor():
		jumps=extra_jumps
	if jumps>0 and Input.is_action_just_pressed("jump"):
		jumps-=1
		if not is_on_floor():
			$jump_sfx.play()
		gravity_vector=Vector3(0,10,0)
	input_direction = 20*input_direction.normalized().rotated(Vector3.UP,$camera.rotation.y)


func update_power(delta):
	power = 0
	var speed = abs((input_direction+velocity+gravity_vector).length()-10)
	power += demon*speed
	power += juke_power
	juke_power=clamp(juke_power-delta,0,100)
	$power_light.light_energy=power/4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	process_input(delta)
	move_and_slide(input_direction+velocity+gravity_vector,Vector3.UP)
	if is_on_floor():
		gravity_vector=-get_floor_normal()*10
		velocity*=1-(delta)
	else:
		gravity_vector.y-=delta*20
		velocity*=1-(delta*0.5)
	if(translation.y<-4):
		hurt(100)
	update_power(delta)
