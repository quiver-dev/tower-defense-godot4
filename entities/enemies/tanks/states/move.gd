extends "res://entities/enemies/states/move.gd"


func enter() -> void:
	(owner as Tank).shooter.can_rotate = true


func exit() -> void:
	(owner as Tank).shooter.can_rotate = false


func update(delta: float) -> void:
	super.update(delta)
	if (owner as Tank).is_raycast_colliding():
		emit_signal("finished", "idle")


# Called both when areas and bodies enter the detection radius
func _on_detector_entity_entered(entity: Node2D) -> void:
	if not entity in (owner as Tank).shooter.targets:
		(owner as Tank).shooter.targets.append(entity)
		emit_signal("finished", "shoot")
