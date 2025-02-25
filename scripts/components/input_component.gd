extends Node
class_name InputComponent

var input_horizontal: float = 0.0

#Check input in horizontal direction
func get_horizontal_input() -> float:
	input_horizontal = Input.get_axis("move_left", "move_right")
	
	#Correct joystick input
	if input_horizontal > 0.5 :
		input_horizontal = 1
	elif input_horizontal < -0.5:
		input_horizontal = -1
	else:
		input_horizontal = 0
		
	return input_horizontal

#Check if jump button was pressed
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

#Check if jump button was released
func get_jump_imput_released() -> bool:
	return Input.is_action_just_released("jump")

#Check if crouch button is pressed
func get_crouch_input() -> bool:
	return Input.is_action_pressed("crouch")

#Check if impulse button was pressed
func get_slide_input() -> bool:
	return Input.is_action_just_pressed("slide")
