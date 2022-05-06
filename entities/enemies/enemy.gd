class_name Enemy
extends CharacterBody2D


signal target_changed(pos: Vector2)

@export var rot_speed: float = 10.0
@export var health: int = 10
@export var speed: int = 300

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_label: Label = $StateLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	# Rotate based on current velocity
	sprite.global_rotation = calculate_rot(sprite.global_rotation, delta)
	collision.global_rotation = calculate_rot(collision.global_rotation, delta)


func take_damage(damage: int) -> void:
	health -= damage
	if health < 1:
		print("enemy dead")


# Used to make the enemy rotate to face its current direction,
# with the specified rotation speed
func calculate_rot(start_rot: float, delta: float) -> float:
	return lerp_angle(start_rot, velocity.angle(), rot_speed * delta)


func move_to(pos: Vector2) -> void:
	nav_agent.set_target_location(pos)
	emit_signal("target_changed", nav_agent.get_target_location())


func stop() -> void:
	if velocity == Vector2.ZERO:
		return
	nav_agent.set_velocity(Vector2.ZERO)


func get_fsm() -> StateMachine:
	return $StateMachine as StateMachine


# Emitted by NavigationAgent2D.set_velocity, which can be called by any 
# State class
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _on_state_machine_state_changed(states_stack: Array) -> void:
	state_label.text = (states_stack[0] as State).name
