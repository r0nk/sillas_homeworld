extends Spatial

func _ready():
	set_active(false)

func set_active(active):
	for child in get_children():
		if child.get_class() == "Area":
			child.monitoring=active
			child.visible=active
