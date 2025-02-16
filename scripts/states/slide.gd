extends State

var is_sliding = false

func enter():
	is_sliding = true
	parent.slide_timer.start()
	parent.animations.play('slide')
	parent.slide_component.slide(parent, parent.last_direction)


func update(_delta):
	#TRANSITIONS
	if !is_sliding:
		Transitioned.emit(self,'crouch')
	elif !parent.crouch_collision_check.is_colliding():
		if !parent.is_on_floor():
			if parent.velocity.y <0:
				Transitioned.emit(self, 'jump')
			else: 
				Transitioned.emit(self, 'fall')



func _on_slide_timer_timeout() -> void:
	is_sliding = false
