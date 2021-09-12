extends Area2D

onready var sfx = $RandomAudioStreamPlayer2D
onready var animation = $AnimationPlayer
onready var collision = $CollisionShape2D
onready var recharge_timer = $RechargeTimer
onready var ray = $RayCast2D
onready var ray2 = $RayCast2D

var force := 180


func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		# Make it perpendicular to the normal
		rotation = ray.get_collision_normal().angle() + deg2rad(90)
		ray.enabled = false
		ray2.enabled = false
	if ray2.is_colliding():
		# Make it perpendicular to the normal
		rotation = ray2.get_collision_normal().angle() + deg2rad(45)
		ray.enabled = false
		ray2.enabled = false


func _on_boost_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		sfx.play()
		animation.play("use")
		collision.set_deferred("disabled", true)
		recharge_timer.start()
		
		# Boosts the player
		var vector_rotated := Vector2(force, 0).rotated(rotation)
		area.get_parent().call_deferred("apply_central_impulse", vector_rotated)


func _on_RechargeTimer_timeout() -> void:
	animation.play("recharge")
	collision.set_deferred("disabled", false)

