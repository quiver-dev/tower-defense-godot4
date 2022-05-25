extends Node2D


@onready var objective: Area2D = $Objective
@onready var tile_map: TileMap = $TileMap
@onready var camera: Camera2D = $Camera2D
@onready var spawner: Spawner = $Spawner


func _ready() -> void:
	spawner.start(objective.global_position)
