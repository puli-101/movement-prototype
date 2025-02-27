extends State

func enter():
	parent.animations.play('idle')
	parent.standing_collision.disabled = false
	parent.standing_hitbox.disabled = false

func physics_update(_delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if parent.velocity.x != 0:
		Transitioned.emit(self, 'run')
	if not parent.is_on_floor():
		if parent.velocity.y <0:
			Transitioned.emit(self, 'jump')
		else: 
			Transitioned.emit(self, 'fall')
	if parent.input_component.get_crouch_input():
		Transitioned.emit(self, 'crouch')


func _on_killzone_body_entered(body: Node2D) -> void:
	Transitioned.emit(self, 'dead')
