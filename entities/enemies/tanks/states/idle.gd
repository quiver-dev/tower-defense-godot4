extends "res://entities/enemies/states/idle.gd"


func update(_delta: float) -> void:
	if not (owner as Tank).is_raycast_colliding():
		emit_signal("finished", "move")
