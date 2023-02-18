class_name Motion
extends State


func _move() -> void:
	var next_path_pos: Vector2 = (owner as Enemy).nav_agent.get_next_path_position()
	var cur_agent_pos: Vector2 = (owner as Enemy).global_position
	var new_velocity: Vector2 = cur_agent_pos.direction_to(next_path_pos) * \
			(owner as Enemy).speed
	if (owner as Enemy).nav_agent.avoidance_enabled:
		(owner as Enemy).nav_agent.set_velocity(new_velocity)
	else:
		(owner as Enemy).nav_agent.velocity_computed.emit(new_velocity)
