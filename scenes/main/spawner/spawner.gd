class_name Spawner
extends Node2D
# This scene should be a direct child of the map scene.
# It distinguishes between "field spawns" - i.e. where ground-based entities
# spawn - and "aircraft spawns". This means that field-related markers must 
# be inside a navigable path on the map, while the aircaft ones can be 
# anywhere (preferrably as far as possible from the objective).
# To customize the spawns, in the parent scene select the spawner and make it
# editable. At this point you can move the Marker2D nodes to the desired
# locations.


signal wave_started(current_wave: int)
signal waves_finished

const INITIAL_WAIT := 5.0  # amount of seconds to wait before starting a wave

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var wave_count: int = 3
@export var enemy_count: int = 10
@export var enemies: Dictionary = {
	"infantry_t1": 45,  # higher probability of spawn
	"infantry_t2": 40,
	"tank": 15,
	"helicopter": 5,
}

var objective_pos: Vector2
var map_limits: Rect2
var cell_size: Vector2i
var current_wave := 1

@onready var wave_timer := $WaveTimer as Timer
@onready var enemy_container := $EnemyContainer as Node2D
@onready var field_spawns := [$SpawnLocation1, $SpawnLocation2]
@onready var aircraft_spawn_pos := $AircraftSpawnLocation as Marker2D


# Called once by parent scene when ready
func initialize(_objective_pos: Vector2, _map_limits: Rect2, _cell_size: Vector2i) -> void:
	objective_pos = _objective_pos
	map_limits = _map_limits
	cell_size = _cell_size
	wave_timer.start(INITIAL_WAIT)


# Called on wave timer's timeout
func _start_wave() -> void:
	wave_started.emit(current_wave)
	var tween := create_tween()
	for i in enemy_count:
		var chosen_enemy_path := Scenes.get_enemy_path(_pick_enemy())
		var spawn_delay := randf_range(spawn_rate / 2, spawn_rate)
		tween.tween_callback(_spawn_enemy.bind(chosen_enemy_path)).\
				set_delay(spawn_delay)
	tween.tween_callback(_end_wave)


func _end_wave() -> void:
	if current_wave == wave_count:
		waves_finished.emit()
		return
	current_wave += 1
	enemy_count += current_wave * 10
	wave_timer.start(INITIAL_WAIT)


func _spawn_enemy(enemy_path: String) -> void:
	# spawn an enemy
	var enemy: Enemy = load(enemy_path).instantiate()
	enemy_container.add_child(enemy)
	if enemy is Helicopter:
		# we use the same marked but we randomize its y axis
		aircraft_spawn_pos.global_position.y = randf_range(
				map_limits.position.y * cell_size.y,
				map_limits.end.y * cell_size.y)
		enemy.global_position = aircraft_spawn_pos.global_position
	else:
		# pick a random spawn location from the field spawns
		enemy.global_position = (field_spawns[randi() % field_spawns.size()] \
				as Marker2D).global_position
	enemy.move_to(objective_pos)


# Implementation of the Cumulative Distribution Algorithm, used to spawn 
# things randomly based on weight
func _pick_enemy() -> String:
	var tot_probability: int = 0
	for key in enemies.keys():
		tot_probability += enemies[key]
	var rand_number = randi_range(0, tot_probability - 1)
	var item: String
	for key in enemies.keys():
		if rand_number < enemies[key]:
			item = key
			break
		rand_number -= enemies[key]
	return item
