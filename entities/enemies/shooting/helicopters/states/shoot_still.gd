extends "res://entities/enemies/shooting/states/shoot_still.gd"


func update(_delta: float) -> void:
	if (owner as ShootingEnemy).shooter.can_shoot and \
			(owner as ShootingEnemy).shooter.lookahead.is_colliding():
		(owner as ShootingEnemy).shooter.shoot()
		var shooting_anim := (owner as ShootingEnemy).shooter.gun.animation
		(owner as ShootingEnemy).apply_animation(shooting_anim)
