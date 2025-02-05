extends State

func enter():
	parent.animations.play('jump')
	parent.standing_collision.disabled = false

func physics_update(_delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if !parent.is_on_floor():
		if parent.velocity.y > 0:
			if parent.is_on_wall():
				Transitioned.emit(self, 'wallslide')
			else:
				Transitioned.emit(self, 'fall')
	else:
		Transitioned.emit(self, 'idle')
