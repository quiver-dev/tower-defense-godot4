class_name Bullet
extends Area2D
# This class extends the Area2D node because we don't need advanced
# physics or player-controlled movement.
# It also uses a VisibleOnScreenEnabler2D node to automatically
# disable this scene when the bullet exits the screen.
# WARN: this is probably not optimal due to the presence of a camera


@export var speed: int = 1000
@export var damage: int = 10

var velocity: Vector2
var target  # homing missiles only


func _physics_process(delta: float) -> void:
	global_position += velocity * delta


# Called by the turret, which instantiates a bullet and gives it a target
func start(_position: Vector2, _rotation: float, _target=null) -> void:
	global_position = _position
	rotation = _rotation
	target = _target
	velocity = Vector2.RIGHT.rotated(_rotation) * speed


# Overridden by children scripts
func _on_bullet_body_entered(_body: Node2D) -> void:
	pass


# Overridden by children scripts
func _on_bullet_area_entered(_area: Area2D) -> void:
	pass


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
