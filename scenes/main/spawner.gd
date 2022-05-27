class_name Spawner
extends Node2D


const ENEMY_PATH := "res://entities/enemies/"

@export_range(0.5, 5.0, 0.5) var spawn_rate: float = 2.0
@export var enemy: PackedScene
@export var enemy_count: int = 10

var objective_pos: Vector2

@onready var spawn_timer: Timer = $SpawnTimer
@onready var enemies: Node2D = $Enemies


# Called once by parent scene when ready
func start(_objective_pos: Vector2) -> void:
	objective_pos = _objective_pos
	_start_timer()


func _start_timer() -> void:
	spawn_timer.start(randf_range(spawn_rate / 2, spawn_rate))


func _on_spawn_timer_timeout() -> void:
	# spawn an enemy
	var prob := randi_range(1, 10)
	var _enemy = load(ENEMY_PATH.plus_file("tanks/tank.tscn" if prob < 4 else \
			"enemy.tscn")).instantiate()
	enemies.add_child(_enemy, true)
	_enemy.move_to(objective_pos)
	# reduce enemy count and repeat if necessary
	enemy_count -= 1
	if enemy_count > 0:
		_start_timer()
	else:
		spawn_timer.stop()
