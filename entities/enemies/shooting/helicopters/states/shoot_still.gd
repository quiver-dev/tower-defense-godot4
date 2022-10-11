extends "res://entities/enemies/shooting/states/shoot_still.gd"


# Override parent function 
func enter() -> void:
	(owner as ShootingEnemy).apply_animation("move")


func update(_delta: float) -> void:
	if (owner as ShootingEnemy).shooter.can_shoot and \
			(owner as ShootingEnemy).shooter.lookahead.is_colliding():
		(owner as ShootingEnemy).shooter.shoot()
		var shooting_anim := (owner as ShootingEnemy).shooter.gun.animation
		(owner as ShootingEnemy).apply_animation(shooting_anim)
	if (owner as ShootingEnemy).shooter.targets.is_empty():
		finished.emit("move")


func on_animation_finished() -> void:
	# restore the move animation when shoot_a/b are finished
	var cur_anim := String((owner as ShootingEnemy).sprite.animation)
	if cur_anim in ["shoot_a", "shoot_b"]:
		(owner as ShootingEnemy).apply_animation("move")
