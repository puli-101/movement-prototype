extends Node
class_name InputComponent

var input_horizontal: float = 0.0

#Check input in horizontal direction
func _process(_delta:float) -> void:
	input_horizontal = Input.get_axis("move_left", "move_right")

#Check if jump button was pressed
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

#Check if jump button was released
func get_jump_imput_released() -> bool:
	return Input.is_action_just_released("jump")
