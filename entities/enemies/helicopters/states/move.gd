extends "res://entities/enemies/states/move.gd"


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in (owner as Helicopter).shooter.targets:
		(owner as Helicopter).shooter.targets.append(body)
		finished.emit("shoot")


func _on_detector_area_entered(area: Area2D) -> void:
	if area is Objective:
		(owner as Helicopter).shooter.targets.append(area)
		finished.emit("shoot")
