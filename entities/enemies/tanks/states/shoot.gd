extends Motion


func enter() -> void:
	(owner as Tank).apply_animation("move") # TODO: review this


func update(_delta: float) -> void:
	_move()
	if (owner as Tank).shooter.can_shoot and \
			(owner as Tank).shooter.lookahead.is_colliding():
		(owner as Tank).shooter.shoot()


func _on_detector_entity_exited(entity: Node2D) -> void:
	if entity in (owner as Tank).shooter.targets:
		(owner as Tank).shooter.targets.erase(entity)
		if (owner as Tank).shooter.targets.is_empty():
			finished.emit("move")
