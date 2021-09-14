extends Node2D




func _ready() -> void:
	return
	# Very inelegant
	for i in get_children():
		if i is RigidBody2D:
			for g in get_children():
				if g is RigidBody2D:
					i.add_collision_exception_with(g)
	$Head.add_central_force(Vector2.UP.rotated(rotation) * 10)
