extends State


func enter() -> void:
	(owner as Enemy).stop()


func update(delta: float) -> void:
	var target_pos: Vector2 = (owner as Tank).shooter.targets.front().global_position
	var target_rot: float = (owner as Tank).global_position.direction_to(target_pos).angle()
	(owner as Tank).shooter.gun.rotation = lerp_angle(
			(owner as Tank).shooter.gun.rotation,
			target_rot, (owner as Tank).shooter.rot_speed * delta)
	if (owner as Tank).shooter.can_shoot:
		(owner as Tank).shooter.shoot()


func _on_detector_entity_exited(entity: Node2D) -> void:
	if entity in (owner as Tank).shooter.targets:
		(owner as Tank).shooter.targets.erase(entity)
		if (owner as Tank).shooter.targets.is_empty():
			emit_signal("finished", "move")
