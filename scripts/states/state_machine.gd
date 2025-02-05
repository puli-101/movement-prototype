extends Node

@onready var parent = get_parent()

@export var initial_state : State

var current_state : State
var states: Dictionary = {}

func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state	

func process_frame(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func process_physics(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
