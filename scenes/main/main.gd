extends Node2D


@onready var objective: Area2D = $Objective
@onready var tile_map: TileMap = $TileMap
@onready var camera: Camera2D = $Camera2D
@onready var enemies: Node2D = $Enemies


func _ready() -> void:
	for enemy in enemies.get_children():
		(enemy as Enemy).move_to(objective.global_position)
