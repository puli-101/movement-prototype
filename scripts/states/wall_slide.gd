extends State

func enter():
	parent.animations.play('wall_slide')
	parent.standing_collision.disabled = false

func physics_update(_delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if !parent.is_on_wall_only():
		Transitioned.emit(self, 'fall')
	if !parent.is_on_floor():
		if parent.velocity.y < 0:
			Transitioned.emit(self, 'jump')
	else:
		Transitioned.emit(self, 'idle')
