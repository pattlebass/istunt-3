class_name Player

extends RigidBody2D

const TURNING_SPEED = 20
const MAX_TURNING_VELOCITY = 8
const ACCELERATION = 5
const MAX_SPEED = 7000
const JUMP_FORCE = 200

var direction = 1
var reset = false


onready var ray = $RayCast2D
onready var jump_sfx = $AudioStreams/JumpStream


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_direction"):
		direction *= -1

func _physics_process(delta: float) -> void:
	#print(linear_velocity)
	# Movement
	var desired_angular_vel = angular_velocity
	if !ray.is_colliding(): # If not on ground
		if Input.is_action_pressed("left"): # Rotate left
			desired_angular_vel -= TURNING_SPEED * delta
		elif Input.is_action_pressed("right"): # Rotate right
			desired_angular_vel += TURNING_SPEED * delta
	
	# Clamp velocities
	angular_velocity = clamp(
				desired_angular_vel,
				-MAX_TURNING_VELOCITY,
				MAX_TURNING_VELOCITY
	)
	linear_velocity.x = clamp(
		linear_velocity.x,
		-MAX_SPEED,
		MAX_SPEED
	)
	
	if ray.is_colliding(): # If on ground
		# Accelerate
		var force = Vector2(ACCELERATION, 0) * direction
		apply_central_impulse(force.rotated(rotation))
		
		# Jump
		if Input.is_action_just_pressed("jump"):
			apply_central_impulse(Vector2(0, -JUMP_FORCE).rotated(rotation))
			jump_sfx.play()


func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if reset:
		set_deferred("mode", MODE_STATIC)
		set_deferred("global_position", Vector2.ZERO)
		set_deferred("rotation_degrees", 0)
		set_deferred("reset", false)
		set_deferred("mode", MODE_RIGID)
