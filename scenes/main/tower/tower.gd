class_name Objective
extends Area2D


signal tower_destroyed

const DEFAULT_DAMAGE := 1  # default damage dealt by enemies

@export_range(0, 1000) var health: int = 500


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		# TODO: add logic
		tower_destroyed.emit()
		print("tower destroyed")


func _on_objective_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage(DEFAULT_DAMAGE)
		# WARN: this won't emit the enemy_dead signal
		(body as Enemy).queue_free()
