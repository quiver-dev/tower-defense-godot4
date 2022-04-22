class_name Enemy
extends CharacterBody2D


signal target_changed(pos: Vector2)

var speed: int = 300

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_label: Label = $StateLabel


func move_to(pos: Vector2) -> void:
	nav_agent.set_target_location(pos)
	emit_signal("target_changed", nav_agent.get_target_location())


func stop() -> void:
	if velocity == Vector2.ZERO:
		return
	nav_agent.set_velocity(Vector2.ZERO)


# Emitted by NavigationAgent2D.set_velocity, which can be called by any 
# State class
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _on_state_machine_state_changed(states_stack: Array) -> void:
	state_label.text = (states_stack[0] as State).name
