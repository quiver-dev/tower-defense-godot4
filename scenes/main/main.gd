extends Node2D


var char_speed: int = 300

@onready var target: Position2D = $Target
@onready var test: CharacterBody2D = $Test
@onready var nav_agent: NavigationAgent2D = $Test/NavigationAgent2D


func _ready() -> void:
	nav_agent.set_target_location(target.position)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		target.global_position = get_global_mouse_position()
		nav_agent.set_target_location(target.global_position)


func _physics_process(_delta: float) -> void:
	var next_path_pos: Vector2 = nav_agent.get_next_location()
	var cur_agent_pos: Vector2 = test.global_position
	var new_velocity: Vector2 = (next_path_pos - cur_agent_pos).normalized() * char_speed
	nav_agent.set_velocity(new_velocity)


# Emitted by set_velocity
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	test.velocity = safe_velocity
	test.move_and_slide()
