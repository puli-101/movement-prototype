extends CharacterBody2D

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
	if not is_on_floor():
		velocity += get_gravity() * delta
	
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
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("jump")

	if direction:
		velocity.x = direction * speed
		facing = direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
