extends Motion


func handle_input(event: InputEvent) -> InputEvent:
	if event is InputEventMouseButton and event.is_pressed() and \
			event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos := (owner as Enemy).get_global_mouse_position()
		(owner as Enemy).move_to(click_pos)
	return super.handle_input(event)


func update(_delta: float) -> void:
	_move()


func _on_navigation_agent_2d_target_reached() -> void:
	emit_signal("finished", "idle")
