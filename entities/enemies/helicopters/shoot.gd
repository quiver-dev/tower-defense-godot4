extends Motion


func enter() -> void:
	(owner as Enemy).stop()
	(owner as Helicopter).apply_animation("move") # TODO: review this


func update(_delta: float) -> void:
	if (owner as Helicopter).shooter.can_shoot and \
			(owner as Helicopter).shooter.lookahead.is_colliding():
		(owner as Helicopter).shooter.shoot()


func _on_detector_entity_exited(body: Node2D) -> void:
	if body in (owner as Helicopter).shooter.targets:
		(owner as Helicopter).shooter.targets.erase(body)
		if (owner as Helicopter).shooter.targets.is_empty():
			finished.emit("move")


func _on_detector_body_exited(body: Node2D) -> void:
	if body in (owner as Helicopter).shooter.targets:
		(owner as Helicopter).shooter.targets.erase(body)
		if (owner as Helicopter).shooter.targets.is_empty():
			finished.emit("move")
