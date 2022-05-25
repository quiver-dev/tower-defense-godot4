extends Area2D


signal tower_destroyed

@export_range(0, 100) var health: int = 50


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		# TODO: add logic
		emit_signal("tower_destroyed")
		print("tower destroyed")


func _on_objective_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage(1)  # WARN: hardcoded value
		body.queue_free()
