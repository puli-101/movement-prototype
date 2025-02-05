extends State

var can_uncrouch = true

func enter():
	parent.animations.play('crouch')
	parent.standing_collision.disabled = true

func physics_update(_delta):
	#Handle horizontal movement form crouch
	parent.crouch_component.handle_crouch_movement(parent, parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if !parent.input_component.get_crouch_input() and !parent.crouch_collision_check.is_colliding():
		Transitioned.emit(self, 'idle')
	elif parent.input_component.get_slide_input():
		Transitioned.emit(self, 'slide')
