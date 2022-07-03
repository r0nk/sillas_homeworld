extends KinematicBody

var input_direction = Vector3()
var velocity = Vector3(0,0.001,0)
var accel = Vector3(0,0,0)
var gravity_vector = Vector3(0,-98,0)
var health = 100
#probably a better way of doing this but yolo lmao
var is_player = true
var dead = false
var move_locked = false

var shift_timer=0

var jumps=0
var extra_jumps=1
var power=0

var weapon_array = [[0,1]]

signal player_killed

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$camera/HUD/crosshair.rect_position = get_viewport().size/2

func _input(event):
	if (event is InputEventMouseMotion) and not move_locked:
		$camera.rotation_degrees.x=clamp($camera.rotation_degrees.x-event.relative.y*0.2,-90,90)
		$camera.rotation_degrees.y-=event.relative.x*0.2

func get_aim():
	return -$camera.transform.basis.z

func process_interactibles():
	if $camera/interact_cast.is_colliding():
		var body = $camera/interact_cast.get_collider()
		if body.is_in_group("interactibles"):
			$camera/HUD/undercross.text="Press [G] to Interact."
			if Input.is_action_pressed("interact"):
				body.interact(get_node("."))
	else:
		$camera/HUD/undercross.text=""

func process_input(delta):
	input_direction = Vector3()
	if(move_locked):
		return
	process_interactibles()

	var forward=Vector3(0,0,-1)

	if Input.is_action_pressed("movement_forward"):
		input_direction+=forward
	if Input.is_action_pressed("movement_backward"):
		input_direction+=-forward
	if Input.is_action_pressed("movement_left"):
		input_direction+=forward.rotated(-gravity_vector.normalized(),(3.14/2))
	if Input.is_action_pressed("movement_right"):
		input_direction+=-forward.rotated(-gravity_vector.normalized(),(3.14/2))

	if(input_direction.length() > 0) and is_on_floor():
		if not $footsteps.playing:
			$footsteps.play()
	else:
		$footsteps.stop()

	if is_on_floor():
		jumps=extra_jumps
	if jumps>0 and Input.is_action_just_pressed("jump"):
		jumps-=1
#		if not is_on_floor():
#			$jump_sfx.play()
		velocity=-gravity_vector.normalized()*5
	input_direction = 10*input_direction.normalized().rotated(-gravity_vector.normalized(),$camera.rotation.y)

func dialogic_event_handler(e):
	if e == "unlock_player":
		move_locked=false

#http://kidscancode.org/godot_recipes/3d/3d_align_surface/
#I'm a kid okay
func align_with_y(xform,new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	process_input(delta)
	accel += gravity_vector*delta
	velocity += accel*delta
	move_and_slide(input_direction+velocity,-gravity_vector.normalized())
#	move_and_slide(input_direction+velocity,Vector3.UP)

	global_transform=global_transform.interpolate_with(align_with_y(global_transform,-gravity_vector.normalized()),0.3)

	for i in get_slide_count():
		var collision = get_slide_collision(i)

	if is_on_floor():
#		accel=-get_floor_normal()*10
		accel*=0
		velocity*=1-(delta*5)
	else:
		velocity*=1-(delta*0.5)
