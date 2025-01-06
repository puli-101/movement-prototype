extends "res://scripts/state_machines/state_machine.gd"

@export var sprite: AnimatedSprite2D

func _ready() -> void:
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("crouch")
	add_state("slide")
	call_deferred('set_state', states.idle)

func _state_logic(delta):
	parent._move_player(delta)

func _get_transition(_delta):
	match state:
		states.idle:
			if parent.input_component.get_jump_input():
				return states.jump
			elif parent.input_component.get_crouch_input():
				return states.crouch
			elif parent.input_component.input_horizontal != 0:
				return states.run
		states.run:
			if not parent.is_on_floor():
				return states.jump
			elif parent.input_component.get_crouch_input():
				return states.crouch
			elif parent.input_component.input_horizontal == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
		states.crouch:
			if parent.movement_component.is_sliding:
				return states.slide
			if !parent.input_component.get_crouch_input():
				return states.idle
		states.slide:
			if not parent.movement_component.is_sliding:
				return states.crouch

func _enter_state(new_state, _old_state):
	match new_state:
		states.idle:
			parent.get_node("StandingCollision").disabled = false
			sprite.play("idle")
		states.run:
			sprite.play("run")
		states.jump:
			sprite.play("jump")
		states.crouch:
			parent.get_node("StandingCollision").disabled = true
			sprite.play("crouch")
		states.slide:
			sprite.play("slide")

func _exit_state(_old_state, _new_state):
	pass
