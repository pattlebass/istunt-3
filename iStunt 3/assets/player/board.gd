extends RigidBody2D

const turning_speed = 2
const speed = 2
const max_speed = 5000
const jump_force = 100

func _physics_process(delta):
	print(get_colliding_bodies())
	#Caps linear_velocity.x
	if linear_velocity.x > max_speed:
		linear_velocity.x = max_speed
	#Movement
	if !$RayCast2D.is_colliding():
		if Input.is_action_pressed("left"):
			angular_velocity = lerp(angular_velocity, -turning_speed, delta * 20)
		if Input.is_action_pressed("right"):
			angular_velocity = lerp(angular_velocity, turning_speed, delta * 20)
	if get_colliding_bodies():
		apply_central_impulse((Vector2(speed, 0).rotated(rotation)))
		if Input.is_action_just_pressed("jump"):
			apply_central_impulse(Vector2(0, -jump_force).rotated(rotation))
			
