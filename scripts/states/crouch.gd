extends State


func enter():
	parent.animations.play('crouch')
	parent.standing_collision.disabled = true
	parent.can_wall_jump = false

func physics_update(delta):
	#Handle horizontal movement form crouch
	parent.crouch_component.handle_crouch_movement(parent, parent.input_component.get_horizontal_input())
	parent.gravity_component.apply_jump_gravity(parent, delta)
	parent.handle_horizontal_flip(parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if !parent.input_component.get_crouch_input() and !parent.crouch_collision_check.is_colliding():
		Transitioned.emit(self, 'idle')
	elif parent.input_component.get_slide_input():
		Transitioned.emit(self, 'slide')

func exit():
	parent.can_wall_jump = true
