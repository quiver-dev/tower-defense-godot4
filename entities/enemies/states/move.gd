extends State


func update(delta: float) -> void:
	var next_path_pos: Vector2 = (owner as Enemy).nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = (owner as Enemy).global_position
	var new_velocity: Vector2 = (next_path_pos - cur_agent_pos).normalized() * \
			(owner as Enemy).speed
	(owner as Enemy).nav_agent.set_velocity(new_velocity)
