class_name Enemy
extends CharacterBody2D


signal target_changed(pos: Vector2)
signal enemy_dead

const GREEN_BAR := preload("res://assets/textures/green_bar.png")
const RED_BAR := preload("res://assets/textures/red_bar.png")

@export var rot_speed: float = 10.0
@export var health: int = 100
@export var speed: int = 300

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var state_label := $StateLabel as Label
@onready var healthbar := $Healthbar as TextureProgressBar


func _ready() -> void:
	# initialize HUD
	state_label.text = get_fsm().current_state.name
	healthbar.max_value = health
	healthbar.value = healthbar.max_value
	# initialize navigation agent
	nav_agent.max_speed = speed


func _physics_process(delta: float) -> void:
	# Rotate based on current velocity
	sprite.global_rotation = _calculate_rot(sprite.global_rotation,
			velocity.angle(), rot_speed, delta)
	collision.global_rotation = _calculate_rot(collision.global_rotation,
			velocity.angle(), rot_speed, delta)


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	healthbar.value = health
	if health == 0:
		# TODO: add logic
		emit_signal("enemy_dead")
		queue_free()


func move_to(pos: Vector2) -> void:
	nav_agent.set_target_location(pos)
	emit_signal("target_changed", nav_agent.get_target_location())


func stop() -> void:
	if velocity == Vector2.ZERO:
		return
	nav_agent.set_velocity(Vector2.ZERO)


func get_fsm() -> StateMachine:
	return $StateMachine as StateMachine


# Used to make the enemy rotate to face its current direction,
# with the specified rotation speed and using interpolation
func _calculate_rot(start_rot: float, target_rot: float, _speed: float, delta: float) -> float:
	return lerp_angle(start_rot, target_rot, _speed * delta)


# Emitted by NavigationAgent2D.set_velocity, which can be called by any 
# State class
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()


func _on_state_machine_state_changed(states_stack: Array) -> void:
	state_label.text = (states_stack[0] as State).name


# Used to display different textures based on the health percentage
func _on_healthbar_value_changed(value: float) -> void:
	healthbar.texture_progress = RED_BAR if value <= healthbar.max_value / 4 \
			else GREEN_BAR
