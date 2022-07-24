extends "res://entities/enemies/states/die.gd"


# Plays the "explode" animation for the shooter module.
# Note that it MUST have the same FPS and number of frames of the
# tank basement's "explode" animation.
func enter() -> void:
	super.enter()
	(owner as Tank).shooter.explode()
	(owner as Tank).explosion.show()
	(owner as Tank).explosion.play("default")