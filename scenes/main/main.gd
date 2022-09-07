extends Node2D


const STARTING_MONEY := 5000

@onready var tower := $Tower as Area2D
@onready var spawner := $Spawner as Spawner
@onready var camera := $Camera2D as Camera2D
@onready var tilemap := $TileMap as TileMap


func _ready() -> void:
	randomize()
	# initialize money
	Global.money = STARTING_MONEY
	# initialize camera
	var map_limits := tilemap.get_used_rect()
	var cell_size := tilemap.tile_set.tile_size
	camera.limit_left = int(map_limits.position.x) * cell_size.x
	camera.limit_top = int(map_limits.position.y) * cell_size.y
	camera.limit_right = int(map_limits.end.x) * cell_size.x
	camera.limit_bottom = int(map_limits.end.y) * cell_size.y
	# start spawning enemies
	spawner.initialize(tower.global_position, map_limits, cell_size)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and \
			event.button_index == MOUSE_BUTTON_LEFT:
		# if there's a turret actions UI visible, hide it
		if Global.turret_actions:
			Global.turret_actions.hide()
