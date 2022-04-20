class_name Enemy
extends CharacterBody2D


signal target_changed(pos: Vector2)

var speed: int = 300

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		nav_agent.set_target_location(get_global_mouse_position())
		emit_signal("target_changed", nav_agent.get_target_location())


func stop() -> void:
	nav_agent.set_velocity(Vector2.ZERO)


# Emitted by NavigationAgent2D.set_velocity, which can be called by any 
# State class
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
