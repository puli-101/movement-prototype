extends Node
class_name GravityComponent

@export_subgroup("Settings")
@export var jump_gravity: float = 1000.0
@export var fall_gravity: float = 1200.0
@export var wall_slide_gravity: float = 200.0

var is_falling: bool = false

func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		if is_falling:
			if body.is_on_wall_only():
				body.velocity.y += wall_slide_gravity * delta
				body.velocity.y = min(body.velocity.y, wall_slide_gravity) #Limit max velocity
			else:
				body.velocity.y += fall_gravity * delta
		else:
			body.velocity.y += jump_gravity * delta
	
	is_falling = body.velocity.y > 0 and not body.is_on_floor()

func apply_jump_gravity(body: CharacterBody2D, delta: float) -> void:
	body.velocity.y += jump_gravity * delta
	
func apply_wall_slide_gravity(body: CharacterBody2D, delta: float) -> void:
	body.velocity.y += wall_slide_gravity * delta
	body.velocity.y = min(body.velocity.y, wall_slide_gravity) #Limit max velocity

func apply_fall_gravity(body: CharacterBody2D, delta: float) -> void:
	body.velocity.y += fall_gravity * delta
