extends Area2D

onready var stream = $RandomAudioStreamPlayer2D
onready var animation = $AnimationPlayer
onready var collision = $CollisionShape2D
onready var recharge_timer = $RechargeTimer


var force := 100

func _on_boost_body_entered(body: Node) -> void:
	if body is Player:
		stream.play()
		animation.play("use")
		collision.set_deferred("disabled", true)
		recharge_timer.start()


func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	if bodies:
		for body in bodies:
			if body is Player:
				var vector_rotated := Vector2(force, 0).rotated(rotation)
				body.apply_central_impulse(vector_rotated)


func _on_RechargeTimer_timeout() -> void:
	animation.play("recharge")
	collision.set_deferred("disabled", false)
