extends Node2D


@onready var target: Position2D = $Target
@onready var enemy: CharacterBody2D = $Enemy
@onready var tile_map: TileMap = $TileMap
@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	target.hide()


func _on_enemy_target_changed(pos: Vector2) -> void:
	target.show()
	target.position = pos
