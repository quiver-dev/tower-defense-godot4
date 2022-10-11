extends "res://entities/enemies/states/move.gd"


func update(delta: float) -> void:
	super(delta)
	# check if we need to exit the state
	if (owner as ShootingEnemy).shooter.targets.size() > 0:
		finished.emit("shoot" if (owner as ShootingEnemy).shooter.targets[-1] \
				is CharacterBody2D else "shoot_still")
