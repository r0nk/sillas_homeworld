extends KinematicBody

var d_y = 1

var point_1 = Vector3(-112,31.5,-12)
var point_2 = Vector3(-112,-260,-12)

var destination = point_1

var wait_timer = 2
var speed=20

func _process(delta):
	if wait_timer > 0:
		wait_timer-=delta
		return
	var v = destination - translation
	translation +=v.normalized()*delta*speed


	if(translation.distance_to(destination)<0.5):
		wait_timer=2
		if (translation.distance_squared_to(point_1) > translation.distance_squared_to(point_2)):
			destination = point_1
		else:
			destination = point_2




