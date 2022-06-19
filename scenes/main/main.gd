extends Node2D


@onready var objective := $Objective as Area2D
@onready var spawner := $Spawner as Spawner
@onready var camera := $Camera2D as Camera2D
@onready var tilemap := $TileMap as TileMap


func _ready() -> void:
	# start spawning enemies
	spawner.start(objective.global_position)
	# initialize camera
#	var map_limits := tilemap.get_used_rect()
#	var cell_size := tilemap.tile_set.tile_size
#	camera.limit_left = int(map_limits.position.x) * cell_size.x
#	camera.limit_bottom = int(map_limits.position.y) * cell_size.y
#	camera.limit_right = int(map_limits.end.x) * cell_size.x
#	camera.limit_top = int(map_limits.end.y) * cell_size.y
