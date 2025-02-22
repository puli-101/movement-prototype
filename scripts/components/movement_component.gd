extends Node
class_name MovementComponent

#Exports
@export_subgroup("Settings")
@export var max_speed: float = 130.0
@export var ground_accel_speed: float = 6.0
@export var ground_decel_speed: float = 80.0
@export var air_accel_speed: float = 10.0
@export var air_decel_speed: float = 10.0

var finish_sliding = false

func handle_horizontal_movement(body: CharacterBody2D, direction: float) -> void:
	var velocity_change_speed: float = 0.0
	if just_finished_sliding(body):
		if body.is_on_floor():
			body.velocity.x = max_speed
		else:
			velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed
			body.velocity.x = move_toward(body.velocity.x, direction * max_speed, velocity_change_speed)
	else:
		if body.is_on_floor():
			velocity_change_speed = ground_accel_speed if direction != 0 else ground_decel_speed
		else:
			velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed
			
		body.velocity.x = move_toward(body.velocity.x, direction * max_speed, velocity_change_speed)

func just_finished_sliding(body) -> bool:
	return body.velocity.x > max_speed or body.velocity.x < -max_speed
