extends Node2D


var char_speed: int = 300

@onready var target: Position2D = $Target
@onready var enemy: CharacterBody2D = $Enemy


func _ready() -> void:
	enemy.nav_agent.set_target_location(target.position)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		target.global_position = get_global_mouse_position()
		enemy.nav_agent.set_target_location(target.global_position)


func _physics_process(_delta: float) -> void:
	var next_path_pos: Vector2 = enemy.nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = enemy.global_position
	var new_velocity: Vector2 = (next_path_pos - cur_agent_pos).normalized() * char_speed
	enemy.nav_agent.set_velocity(new_velocity)


# Emitted by set_velocity
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	enemy.velocity = safe_velocity
	enemy.move_and_slide()
