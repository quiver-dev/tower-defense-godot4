extends State


func enter() -> void:
	(owner as ShootingEnemy).apply_animation("shoot_still")


func update(_delta: float) -> void:
	if (owner as ShootingEnemy).shooter.can_shoot and \
			(owner as ShootingEnemy).shooter.lookahead.is_colliding():
		(owner as ShootingEnemy).shooter.shoot()
	if (owner as ShootingEnemy).shooter.targets.is_empty():
		finished.emit("move")
