extends CharacterBody2D
class_name Player

@onready var state_machine = $StateMachine
@onready var animations = $Animations
@onready var crouch_collision_check = $CrouchCollisionCheck
@onready var standing_collision = $StandingCollision
@onready var slide_timer = $SlideComponent/SlideTimer

#exports
@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var advanced_jump_component: AdvancedJumpComponent
@export var crouch_component: CrouchComponent
@export var slide_component: SlideComponent


#Variables
var can_wall_jump = true
var last_direction = 1.0

func _ready() -> void:
	state_machine.init(self)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	#COMPONENTS CALLED FOR EVERY STATE
	advanced_jump_component.handle_jump(self, input_component.get_jump_input(), input_component.get_jump_imput_released(), can_wall_jump)
	
	#Handle horizontal flip for animations
	handle_horizontal_flip(input_component.get_horizontal_input())
	get_last_direction_pressed(input_component.get_horizontal_input())
	
	#STATE MACHINE
	state_machine.process_physics(delta)
	move_and_slide()
	
	animations.scale.x = move_toward(animations.scale.x, 1, 3 * delta)
	animations.scale.y = move_toward(animations.scale.y, 1, 3 * delta)

#Flip sprite depending on direction pressed
func handle_horizontal_flip(move_direction: float) -> void:
	if move_direction == 0:
		return
	
	animations.flip_h = false if move_direction > 0 else true

func get_last_direction_pressed(move_direction: float) -> void:
	if move_direction == 0:
		return
	else: 
		last_direction = move_direction
	
