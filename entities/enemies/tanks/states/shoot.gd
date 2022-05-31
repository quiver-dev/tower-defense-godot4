extends State


func enter() -> void:
	(owner as Enemy).stop()


func update(delta: float) -> void:
	var target_pos: Vector2 = (owner as Tank).targets.front().global_position
	var target_rot: float = (owner as Tank).global_position.direction_to(target_pos).angle()
	(owner as Tank).gun.rotation = lerp_angle((owner as Tank).gun.rotation,
			target_rot, (owner as Tank).turret_speed * delta)
	if (owner as Tank).can_shoot:
		(owner as Tank).shoot((owner as Tank).targets.front().global_position)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in (owner as Tank).targets:
		(owner as Tank).targets.erase(body)
		if (owner as Tank).targets.is_empty():
			emit_signal("finished", "move")
