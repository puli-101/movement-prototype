extends CharacterBody2D

#exports
@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var advanced_jump_component: AdvancedJumpComponent
@export var player_state_machine: StateMachine
@export var slide_component: SlideComponent
@export var crouch_collision_check: RayCast2D

#Variables
var can_uncrouch = true

#updates every 1/60s
func _move_player(delta) -> void:
	# Add the gravity.
	gravity_component.handle_gravity(self, delta)

	#Check if player can uncrouch
	if crouch_collision_check.is_colliding():
		can_uncrouch = false
	else:
		can_uncrouch = true
		
	#Get input and handle horizontal movement
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal, player_state_machine.states, player_state_machine.state)
	
	#Handle animations
	animation_component.handle_horizontal_flip(input_component.input_horizontal)
	
	#Handle jump
	advanced_jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_imput_released(), can_uncrouch)
	
	#Handle slide
	slide_component.handle_slide(self, input_component.input_horizontal, input_component.get_crouch_input(), input_component.get_slide_input())
	
	move_and_slide()


	
