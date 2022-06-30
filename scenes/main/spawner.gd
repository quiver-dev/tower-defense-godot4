class_name Spawner
extends Node2D


const INITIAL_WAIT := 5.0  # amount of seconds to wait before starting

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var enemy_count: int = 10
@export var enemies: Dictionary = {
	"infantry_t1": 45,  # higher probability of spawn
	"infantry_t2": 40,
	"tank": 15,
}

var objective_pos: Vector2

@onready var spawn_timer := $SpawnTimer as Timer
@onready var enemy_container := $EnemyContainer as Node2D


# Called once by parent scene when ready
func start(_objective_pos: Vector2) -> void:
	objective_pos = _objective_pos
	spawn_timer.start(INITIAL_WAIT)


func _start_timer() -> void:
	spawn_timer.start(randf_range(spawn_rate / 2, spawn_rate))


func _on_spawn_timer_timeout() -> void:
	# spawn an enemy
	var chosen_enemy_path := Scenes.get_enemy_path(_spawn_item())
	var enemy: Enemy = load(chosen_enemy_path).instantiate()
	enemy_container.add_child(enemy)
	enemy.move_to(objective_pos)
	# reduce enemy count and repeat if necessary
	enemy_count -= 1
	if enemy_count > 0:
		_start_timer()
	else:
		spawn_timer.stop()


# Implementation of the Cumulative Distribution Algorithm, used to spawn 
# things randomly based on weight
func _spawn_item() -> String:
	var tot_probability: int = 0
	for key in enemies.keys():
		tot_probability += enemies[key]
	var rand_number = randi_range(0, tot_probability)
	var item: String
	for key in enemies.keys():
		if rand_number < enemies[key]:
			item = key
			break
		rand_number -= enemies[key]
	return item
