class_name StateMachine
extends Node
# The point of the State pattern is to separate concerns, to help follow
# the single responsibility principle. Each state describes an action or behavior.
# The state machine is the only entity that's aware of the states. 
# That's why this script receives strings from the states: it maps 
# these strings to actual state objects: the states (Move, Jump, etc.)
# are not aware of their siblings. This way you can change any of 
# the states anytime without breaking the game.


signal state_changed(states_stack: Array)

# You must set a starting node from the inspector or on
# the node that inherits from this state machine interface
# If you don't the game will crash (on purpose, so you won't 
# forget to initialize the state machine)
@export var START_STATE: NodePath

# This example keeps a history of some states so e.g. after taking a hit,
# the character can return to the previous state. The states_stack is 
# an Array, and we use Array.push_front() and Array.pop_front() to add and
# remove states from the history.
var states_map := {}
var states_stack: Array[Object] = []
var current_state: State = null


func _ready() -> void:
	for state_node in get_children():
		state_node.finished.connect(_change_state)
	initialize(START_STATE)


# The state machine delegates process and input callbacks to the current state
# The state object, e.g. Move, then handles input, calculates velocity 
# and moves what I called its "host", the Player node (KinematicBody2D) in this case.
func _physics_process(delta: float) -> void:
	current_state.update(delta)


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


# If value is false, it disables the processing, otherwise it enables it
func set_processing(value: bool) -> void:
	set_process_unhandled_input(value)


func initialize(start_state: NodePath) -> void:
	states_stack.push_front(get_node(start_state))
	current_state = states_stack[0]
	current_state.enter()


# We use this method to:
# 	1. Clean up the current state with its the exit method
# 	2. Manage the flow and the history of states
# 	3. Initialize the new state with its enter method
func _change_state(_state_name: String) -> void:
	pass


# We want to delegate every method or callback that could trigger 
# a state change to the state objects. The base script state.gd,
# which all states extend, makes sure that all states have the same
# interface, that is to say access to the same base methods, including
# on_animation_finished. See state.gd
func _on_Sprite_animation_finished() -> void:
	current_state.on_animation_finished()
