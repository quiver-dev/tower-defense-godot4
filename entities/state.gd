class_name State
extends Node
# Base interface for all states: it doesn't do anything in itself
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.


signal finished(next_state_name: String)


# Initialize the state. E.g. change the animation
func enter() -> void:
	return


# Clean up the state. Reinitialize values like a timer
func exit() -> void:
	return


func handle_input(event: InputEvent) -> InputEvent:
	return event


func update(_delta: float) -> void:
	return


# Called by the state machine
func on_animation_finished() -> void:
	return
