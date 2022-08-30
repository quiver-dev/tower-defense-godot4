class_name Spawner
extends Node2D


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
var current_wave := 1
var spawns := []

@onready var wave_timer := $WaveTimer as Timer
@onready var enemy_container := $EnemyContainer as Node2D


# Called once by parent scene when ready
func initialize(_objective_pos: Vector2) -> void:
	for node in get_children():
		if node is Position2D:
			spawns.append(node)
	objective_pos = _objective_pos
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
	enemy.global_position = (spawns[randi() % spawns.size()] as Position2D).\
			global_position
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
