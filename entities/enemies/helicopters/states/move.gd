extends "res://entities/enemies/states/move.gd"


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in (owner as Helicopter).shooter.targets:
		(owner as Helicopter).shooter.targets.append(body)
		finished.emit("shoot")
