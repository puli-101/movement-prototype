extends Node
class_name SlideComponent
#Exports
@export_subgroup("Nodes")
@export var slide_time: Timer

@export_subgroup("Settings")
@export var slide_speed: float = 300.0

var is_sliding: bool = false

func is_allowed_to_slide(body: CharacterBody2D, is_crouching: bool, want_to_slide: bool, direction: float) -> bool:
	return body.is_on_floor() and is_crouching and not is_sliding and want_to_slide and direction != 0

func handle_slide(body:CharacterBody2D, direction: float, is_crouching: bool, want_to_slide: bool) -> void:
	if is_allowed_to_slide(body, is_crouching, want_to_slide, direction):
		slide(body, direction)

#Slide
func slide(body: CharacterBody2D, direction: float) -> void:
	is_sliding = true
	body.velocity.x = direction * slide_speed
	slide_time.start()

#Stop sliding
func _on_slide_time_timeout() -> void:
	is_sliding = false
