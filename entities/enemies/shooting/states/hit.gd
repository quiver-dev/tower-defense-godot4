extends "res://entities/enemies/states/hit.gd"


func enter() -> void:
	super()
	# freeze the reload time for the duration of this state
	(owner as ShootingEnemy).shooter.set_firerate_timer_paused(true)


func exit() -> void:
	super()
	(owner as ShootingEnemy).shooter.set_firerate_timer_paused(false)
