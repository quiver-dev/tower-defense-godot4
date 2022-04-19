extends StateMachine


func _ready() -> void:
	states_map = {
	}


func _change_state(state_name: String) -> void:
	current_state.exit()
	
	states_stack.push_front(states_map[state_name])
	if states_stack.size() > 2:
		states_stack.pop_back()
	
	current_state = states_stack[0]
	emit_signal("state_changed", states_stack)
