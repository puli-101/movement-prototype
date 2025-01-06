extends Node
class_name MovementComponent

#Exports
@export_subgroup("Nodes")
@export var slide_time: Timer

@export_subgroup("Settings")
@export var speed: float = 100.0
@export var crouch_speed: float = 60.0
@export var slide_speed: float = 300.0
@export var ground_accel_speed: float = 6.0
@export var ground_decel_speed: float = 20.0
@export var air_accel_speed: float = 10.0
@export var air_decel_speed: float = 3.0


var is_sliding: bool = false

func handle_horizontal_movement(body: CharacterBody2D, direction: float, is_crouching: bool) -> void:
	if not is_crouching and not is_sliding:
		var velocity_change_speed: float = 0.0
		if body.is_on_floor():
			velocity_change_speed = ground_accel_speed if direction != 0 else ground_decel_speed
		else:
			velocity_change_speed = air_accel_speed if direction != 0 else air_decel_speed
		
		body.velocity.x = move_toward(body.velocity.x, direction * speed, velocity_change_speed)
	elif is_crouching and not is_sliding:
		
		body.velocity.x = direction * crouch_speed


func is_allowed_to_slide(body: CharacterBody2D, is_crouching: bool, want_to_slide: bool, direction: float) -> bool:
	return body.is_on_floor() and is_crouching and not is_sliding and want_to_slide and direction != 0

func handle_slide(body:CharacterBody2D, direction: float, is_crouching: bool, want_to_slide: bool) -> void:
	if is_allowed_to_slide(body, is_crouching, want_to_slide, direction):
		slide(body, direction)

func slide(body: CharacterBody2D, direction: float) -> void:
	is_sliding = true
	body.velocity.x = direction * slide_speed
	slide_time.start()


func _on_slide_time_timeout() -> void:
	is_sliding = false
