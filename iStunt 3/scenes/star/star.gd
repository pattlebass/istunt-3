extends KinematicBody2D

onready var sfx = $DetectionArea/ding

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
	sfx.play()
	yield(sfx, "finished")
	queue_free()


func _on_DetectionArea_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		target = area.get_parent()

func _on_DetectionArea_area_exited(area: Area2D) -> void:
	return
	if area.get_parent() is Player:
		target = null

