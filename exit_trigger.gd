extends Area

func body_entered(body):
	if body.name=="player":
		body.translation = $Destination.global_transform.origin
		body.get_node("camera/HUD/status").print("Hours later...")
