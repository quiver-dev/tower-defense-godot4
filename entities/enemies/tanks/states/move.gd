extends "res://entities/enemies/states/move.gd"


# Called both when areas and bodies enter the detection radius
func _on_detector_entity_entered(entity: Node2D) -> void:
	if not entity in (owner as Tank).shooter.targets:
		(owner as Tank).shooter.targets.append(entity)
		emit_signal("finished", "shoot")
