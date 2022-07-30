class_name Objective
extends Area2D


signal initialized(max_health: int)
signal health_changed(cur_health: int)
signal destroyed

# TODO: this could probably be an Enemy parameter: let that scene check damage
const DEFAULT_DAMAGE := 10  # default damage dealt by enemies

@export_range(0, 1000) var health: int = 500


func _ready() -> void:
	initialized.emit(health)


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		# TODO: add logic
		destroyed.emit()
		print("tower destroyed")
	else:
		health_changed.emit(health)


func _on_objective_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage(DEFAULT_DAMAGE)
		# WARN: this won't emit the enemy_dead signal
		(body as Enemy).queue_free()
