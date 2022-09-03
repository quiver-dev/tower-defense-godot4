extends Motion


func enter() -> void:
	(owner as ShootingEnemy).apply_animation("move") # TODO: review this


func update(_delta: float) -> void:
	_move()
	if (owner as ShootingEnemy).shooter.can_shoot and \
			(owner as ShootingEnemy).shooter.lookahead.is_colliding():
		(owner as ShootingEnemy).shooter.shoot()


func _on_detector_body_exited(body: Node2D) -> void:
	if body in (owner as ShootingEnemy).shooter.targets:
		(owner as ShootingEnemy).shooter.targets.erase(body)
		if (owner as ShootingEnemy).shooter.targets.is_empty():
			finished.emit("move")


func _on_detector_area_exited(area: Area2D) -> void:
	if area in (owner as ShootingEnemy).shooter.targets:
		(owner as ShootingEnemy).shooter.targets.erase(area)
		if (owner as ShootingEnemy).shooter.targets.is_empty():
			finished.emit("move")
