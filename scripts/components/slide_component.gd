extends Node
class_name SlideComponent
#Exports
@export_subgroup("Nodes")
@export var slide_time: Timer

@export_subgroup("Settings")
@export var slide_speed: float = 300.0


#Slide
func slide(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * slide_speed
