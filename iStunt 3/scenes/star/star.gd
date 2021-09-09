extends KinematicBody2D

onready var ding = $DetectionArea/ding

var target

var speed := Player.MAX_SPEED * 0.1


func _physics_process(delta: float) -> void:
	if target:
		if target.global_position.distance_to(global_position) < 10:
			destroy()
			return
		
		var vector: Vector2 = (target.global_position - global_position).normalized()
		speed += delta * 1500
		move_and_slide(vector * speed)


func destroy():
	target = null
	hide()
	ding.play()
	yield(ding, "finished")
	queue_free()


func _on_DetectionArea_body_entered(body: Node) -> void:
	if body is Player:
		target = body

func _on_DetectionArea_body_exited(body: Node) -> void:
	return
	if body is Player:
		target = null
