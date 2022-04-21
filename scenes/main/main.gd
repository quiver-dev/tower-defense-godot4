extends Node2D


@onready var target: Position2D = $Target
@onready var enemy: CharacterBody2D = $Enemy


func _ready() -> void:
	target.hide()


func _on_enemy_target_changed(pos: Vector2) -> void:
	target.show()
	target.position = pos
