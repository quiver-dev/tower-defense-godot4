extends "res://entities/enemies/shooting/states/move.gd"


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in (owner as ShootingEnemy).shooter.targets:
		(owner as ShootingEnemy).shooter.targets.append(body)
		finished.emit("shoot")


func _on_detector_area_entered(area: Area2D) -> void:
	if not area in (owner as ShootingEnemy).shooter.targets:
		(owner as ShootingEnemy).shooter.targets.append(area)
		finished.emit("shoot_still")
