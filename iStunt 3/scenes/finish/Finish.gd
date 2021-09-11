extends "res://scenes/checkpoint/Checkpoint.gd"



func _on_Checkpoint_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		animation.play("use")
		sfx.play()
