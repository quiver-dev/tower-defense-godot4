extends "res://entities/enemies/states/move.gd"


func update(delta: float) -> void:
	super.update(delta)
	(owner as Tank).gun.rotation = lerp_angle((owner as Tank).gun.rotation,
			(owner as Tank).velocity.angle(),
			(owner as Tank).turret_speed * delta)


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in (owner as Tank).targets:
		(owner as Tank).targets.append(body)
		emit_signal("finished", "shoot")
