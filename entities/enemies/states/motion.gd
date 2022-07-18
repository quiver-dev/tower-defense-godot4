class_name Motion
extends State


func _move() -> void:
	var next_path_pos: Vector2 = (owner as Enemy).nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = (owner as Enemy).global_position
	var new_velocity: Vector2 = cur_agent_pos.direction_to(next_path_pos) * \
			(owner as Enemy).speed
	(owner as Enemy).nav_agent.set_velocity(new_velocity)
	# DEBUG: visualize path
	# FIXME: not working. For some reason points is always empty
	(owner as Enemy).line2d.points.append(next_path_pos)
