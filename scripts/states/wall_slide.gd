extends State

func enter():
	parent.animations.play('wall_slide')
	parent.standing_collision.disabled = false
	parent.can_wall_jump = true
	if parent.velocity.y < 0:
		parent.velocity.y = 0

func physics_update(delta):
	#Handle horizontal movement
	parent.movement_component.handle_horizontal_movement(parent, parent.input_component.get_horizontal_input())
	parent.gravity_component.apply_wall_slide_gravity(parent, delta)

func update(_delta):
	#TRANSITIONS
	if !parent.is_on_floor():
		if !parent.wall_collision_check.is_colliding() or parent.last_direction != parent.input_component.get_horizontal_input():
			if parent.velocity.y > 0:
				Transitioned.emit(self, 'fall')
			else:
				Transitioned.emit(self, 'jump')
	else:
		Transitioned.emit(self, 'idle')

func exit():
	parent.can_wall_jump = false
