extends "res://entities/enemies/states/hit.gd"
# TODO: rework this in the future. Maybe make it last the duration of 
# the hit animation.


func enter() -> void:
	super()
	# freeze the reload time for the duration of this state
	(owner as Tank).shooter.set_firerate_timer_paused(true)


func exit() -> void:
	super()
	(owner as Tank).shooter.set_firerate_timer_paused(false)
