extends Area

func _on_gravgate_body_entered(body):
	print("enter")
	print(global_transform.basis.z)
	if body.get("gravity_vector"):
		body.gravity_vector=-global_transform.basis.y*98
		body.velocity*=0.1


