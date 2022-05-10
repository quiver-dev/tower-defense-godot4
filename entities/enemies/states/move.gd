extends EnemyState


func handle_input(event: InputEvent) -> InputEvent:
	if event is InputEventMouseButton and event.is_pressed() and \
			event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos := (owner as Enemy).get_global_mouse_position()
		(owner as Enemy).move_to(click_pos)
	return super.handle_input(event)


func update(_delta: float) -> void:
	var next_path_pos: Vector2 = (owner as Enemy).nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = (owner as Enemy).global_position
	var new_velocity: Vector2 = cur_agent_pos.direction_to(next_path_pos) * \
			(owner as Enemy).speed
	(owner as Enemy).nav_agent.set_velocity(new_velocity)


func _on_navigation_agent_2d_target_reached() -> void:
	emit_signal("finished", "idle")
