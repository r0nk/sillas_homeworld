extends Area

func _on_gravgate_body_entered(body):
	if body.get("gravity_vector"):
		body.gravity_vector=-global_transform.basis.y*98
		body.accel*=0


