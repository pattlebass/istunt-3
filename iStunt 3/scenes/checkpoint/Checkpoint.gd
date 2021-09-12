extends Area2D

onready var animation = $AnimationPlayer
onready var ray = $RayCast2D
onready var sfx = $AudioStreamPlayer2D
onready var collision = $CollisionShape2D


func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		# Make the pole perpendicular to the normal
		rotation = ray.get_collision_normal().angle() + deg2rad(90)
		ray.enabled = false

func _on_Checkpoint_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		animation.play("use")
		sfx.play()
		collision.set_deferred("disabled", true)