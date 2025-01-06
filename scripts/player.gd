extends CharacterBody2D

#exports
@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var advanced_jump_component: AdvancedJumpComponent

#speed management
const STD_SPEED = 130.0
const CROUCH_SPEED = 60.0
var speed = STD_SPEED

#leaping/sliding constants
const LEAP_INPULSE = Vector2(500,0)

#updates every 1/60s
func _move_player(delta) -> void:
	# Add the gravity.
	gravity_component.handle_gravity(self, delta)
	
	#Get input and handle horizontal movement
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal, input_component.get_crouch_input())
	
	#Handle animations
	animation_component.handle_horizontal_flip(input_component.input_horizontal)
	
	#Handle jump
	advanced_jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_imput_released())
	
	#Handle slide
	movement_component.handle_slide(self, input_component.input_horizontal, input_component.get_crouch_input(), input_component.get_slide_input())
	
	move_and_slide()
