extends "res://scripts/state_machines/state_machine.gd"

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("idle_crouch")
	add_state("run_crouch")
	add_state("slide")
	call_deferred('set_state', states.idle)

func _state_logic(delta):
	parent._move_player(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			if not parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.input_component.get_crouch_input():
				return states.idle_crouch
			elif parent.velocity.x != 0:
				if parent.input_component.get_crouch_input():
					return states.run_crouch
				else:
					return states.run
		states.run:
			if not parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.input_component.get_crouch_input():
				return states.run_crouch
			elif parent.velocity.x == 0:
				if parent.input_component.get_crouch_input():
					return states.idle_crouch
				else:
					return states.idle
		states.jump:
			if parent.is_on_floor():
				if parent.input_component.get_crouch_input():
					if parent.velocity.x == 0:
						return states.idle_crouch
					else: 
						return states.run_crouch
				elif parent.velocity.x == 0:
					return states.idle
				else:
					return states.run
			else:
				if parent.velocity.y > 0:
					return states.fall
		states.fall:
			if parent.is_on_floor():
				if parent.input_component.get_crouch_input():
					if parent.velocity.x == 0:
						return states.idle_crouch
					else: 
						return states.run_crouch
				elif parent.velocity.x == 0:
					return states.idle
				else:
					return states.run
			else:
				if parent.velocity.y < 0:
					return states.jump
		states.idle_crouch:
			if parent.input_component.get_slide_input():
				return states.slide
			if !parent.input_component.get_crouch_input() and parent.can_uncrouch:
				return states.idle
			if not parent.is_on_floor() and parent.can_uncrouch:
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			if parent.velocity.x != 0:
				if parent.input_component.get_crouch_input():
					return states.run_crouch
				elif parent.can_uncrouch:
					return states.run
		states.run_crouch:
			if parent.slide_component.is_sliding:
				return states.slide
			if !parent.input_component.get_crouch_input() and parent.can_uncrouch:
				return states.run
			if not parent.is_on_floor() and parent.can_uncrouch :
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y < 0:
					return states.fall
			if parent.velocity.x == 0:
				if parent.input_component.get_crouch_input():
					return states.idle_crouch
				elif parent.can_uncrouch:
					return states.idle
		states.slide:
			if not parent.is_on_floor() and parent.can_uncrouch:
					if parent.velocity.y < 0:
						return states.jump
					elif parent.velocity.y > 0:
						return states.fall
			elif not parent.slide_component.is_sliding:
				if parent.input_component.get_crouch_input():
					if parent.velocity.x == 0:
						return states.idle_crouch
					else: 
						return states.run_crouch
				else:
					if parent.velocity.x == 0:
						return states.idle_crouch
					else: 
						return states.run_crouch

func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.get_node("StandingCollision").disabled = false
			sprite.play("idle")
		states.run:
			parent.get_node("StandingCollision").disabled = false
			sprite.play("run")
		states.jump:
			parent.get_node("StandingCollision").disabled = false
			sprite.play("jump")
		states.fall:
			parent.get_node("StandingCollision").disabled = false
			sprite.play("jump")
		states.idle_crouch:
			parent.get_node("StandingCollision").disabled = true
			sprite.play("crouch")
		states.run_crouch:
			parent.get_node("StandingCollision").disabled = true
			sprite.play("crouch")
		states.slide:
			parent.get_node("StandingCollision").disabled = true
			sprite.play("slide")

func _exit_state(_old_state, _new_state):
	pass
