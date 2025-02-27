extends Area2D

@onready var kill_timer = $KillzoneTimer


func _on_killzone_timer_timeout() -> void:
	get_tree().reload_current_scene()
