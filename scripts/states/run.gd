extends State

func enter():
	parent.animations.play('run')
	parent.standing_collision.disabled = false

func physics_update(_delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())
	parent.handle_horizontal_flip(parent.input_component.get_horizontal_input())
	
func update(_delta):
	#TRANSITIONS
	if parent.velocity.x == 0:
		Transitioned.emit(self, 'idle')
	if !parent.is_on_floor():
		if parent.velocity.y <0:
			Transitioned.emit(self, 'jump')
		else: 
			Transitioned.emit(self, 'fall')
	if parent.input_component.get_crouch_input():
		Transitioned.emit(self, 'crouch')
