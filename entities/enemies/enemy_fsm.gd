extends StateMachine
# This class must override the _change_state method to exit the current
# state, do the necessary steps and finally switch to the new state.
# Also, the states_map dictionary will contain all the states' names as
# keys and their path as the relative entry. Each id will be referenced
# from each state and passed on when their "finished" signal is emitted.


func _ready() -> void:
	states_map = {
		"move": $Move,
	}


func _change_state(state_name: String) -> void:
	current_state.exit()
	
	states_stack.push_front(states_map[state_name])
	if states_stack.size() > 2:
		states_stack.pop_back()
	
	current_state = states_stack[0]
	emit_signal("state_changed", states_stack)
