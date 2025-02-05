extends State

var is_sliding = false

func enter():
	is_sliding = true
	parent.slide_timer.start()
	parent.animations.play('slide')

func physics_update(_delta):
	parent.slide_component.slide(parent, parent.input_component.get_horizontal_input())

func update(_delta):
	#TRANSITIONS
	if !is_sliding:
		Transitioned.emit(self,'crouch')
	elif !parent.is_on_floor():
		if parent.velocity.y <0:
			Transitioned.emit(self, 'jump')
		else: 
			Transitioned.emit(self, 'fall')



func _on_slide_timer_timeout() -> void:
	is_sliding = false
