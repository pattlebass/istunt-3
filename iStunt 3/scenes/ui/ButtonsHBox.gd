extends HBoxContainer


func _on_PauseButton_toggled(button_pressed: bool) -> void:
	get_tree().paused = button_pressed


func _on_ResetButton_pressed() -> void:
	Variables.player.reset = true
