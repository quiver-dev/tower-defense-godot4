extends "res://entities/enemies/states/move.gd"


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in (owner as Tank).targets:
		(owner as Tank).targets.append(body)
		# TODO: code shooting state
