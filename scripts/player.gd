extends CharacterBody2D

#exports
@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent
@export var jump_component: JumpComponent

#speed management
const STD_SPEED = 130.0
const CROUCH_SPEED = 60.0
var speed = STD_SPEED

#jump constants
const JUMP_VELOCITY = -300.0

#leaping/sliding constants
const LEAP_INPULSE = Vector2(500,0)

#orientation management
var facing = 1


#updates every 1/60s
func _physics_process(delta: float) -> void:
	# Add the gravity.
	gravity_component.handle_gravity(self, delta)
	
	#Get input and handle horizontal movement
	movement_component.handle_horizontal_movement(self, input_component.input_horizontal)
	
	#Handle animations
	animation_component.handle_move_animation(input_component.input_horizontal)
	animation_component.handle_jump_animation(jump_component.is_jumping, gravity_component.is_falling)
	
	#Handle jump
	jump_component.handle_jump(self, input_component.get_jump_input())
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Handle crouching speeds
	if Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
	else:
		speed = STD_SPEED
	
	#Handle slide
	if Input.is_action_pressed("crouch") and Input.is_action_just_pressed("impulse") and is_on_floor():
		print("slide triggered")
		#Modify collision shape
		#Change sprite
		velocity += LEAP_INPULSE * facing

	
	move_and_slide()
