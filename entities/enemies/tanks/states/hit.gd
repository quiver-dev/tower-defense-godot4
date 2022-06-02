extends "res://entities/enemies/states/hit.gd"
# TODO: rework this in the future. Maybe make it last the duration of 
# the hit animation.


func enter() -> void:
	prev_state = (owner as Enemy).get_fsm().states_stack.back()
	timer.start(state_duration)
