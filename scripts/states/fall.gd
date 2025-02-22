extends State

func enter():
	parent.animations.play('jump')
	parent.standing_collision.disabled = false

func physics_update(delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())
	parent.gravity_component.apply_fall_gravity(parent, delta)
	parent.handle_horizontal_flip(parent.input_component.get_horizontal_input())
	
func update(_delta):
	#TRANSITIONS
	if !parent.is_on_floor():
		if parent.is_on_wall():
			Transitioned.emit(self, 'wallslide')
		if parent.velocity.y < 0:
			Transitioned.emit(self, 'jump')
	else:
		Transitioned.emit(self, 'idle')
