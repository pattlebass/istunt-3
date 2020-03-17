extends RigidBody2D

var turning_speed = 5

func _physics_process(delta):
	for ray in $rays.get_children():
		if !ray.is_colliding():
			if Input.is_action_pressed("left"):
				angular_velocity = lerp(angular_velocity, -turning_speed, delta * 20)
			if Input.is_action_pressed("right"):
				angular_velocity = lerp(angular_velocity, turning_speed, delta * 20)
