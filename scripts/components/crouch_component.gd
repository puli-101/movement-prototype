extends Node
class_name CrouchComponent

#Exports
@export_subgroup("Settings")
@export var crouch_speed: float = 60.0

func handle_crouch_movement(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * crouch_speed
