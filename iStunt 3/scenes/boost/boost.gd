extends Area2D

onready var sfx = $RandomAudioStreamPlayer2D
onready var animation = $AnimationPlayer
onready var collision = $CollisionShape2D
onready var recharge_timer = $RechargeTimer


var force := 180

func _on_boost_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		sfx.play()
		animation.play("use")
		collision.set_deferred("disabled", true)
		recharge_timer.start()
		
		# Boosts the player
		var vector_rotated := Vector2(force, 0).rotated(rotation)
		area.get_parent().call_deferred("apply_central_impulse", vector_rotated)


func _physics_process(delta: float) -> void:
	return


func _on_RechargeTimer_timeout() -> void:
	animation.play("recharge")
	collision.set_deferred("disabled", false)

