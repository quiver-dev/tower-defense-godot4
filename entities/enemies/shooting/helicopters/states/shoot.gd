extends "res://entities/enemies/shooting/states/shoot.gd"


# Override to make helicopter stop when shooting
func update(_delta: float) -> void:
	if (owner as ShootingEnemy).shooter.can_shoot and \
			(owner as ShootingEnemy).shooter.lookahead.is_colliding():
		(owner as ShootingEnemy).shooter.shoot()
