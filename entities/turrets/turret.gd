@tool
class_name Turret
extends CharacterBody2D


const DETECTOR_COLOR := Color(1, 0.22, 0.25, 0.25)

@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float
@export var rot_speed: float = 1.5
@export var bullet_type: PackedScene
@export_range(0, 100) var health: int = 10

var targets: Array[Node2D]
var can_shoot := true

@onready var gun: Sprite2D = $Gun
@onready var coll_radius: CollisionShape2D = $Detector/CollisionShape2D


func _ready() -> void:
	(coll_radius.shape as CircleShape2D).radius = detect_radius


func _physics_process(delta: float) -> void:
	update()
	if targets:
		var target_rot: float = (targets.front().global_position - \
				global_position).normalized().angle()
		gun.global_rotation = lerp_angle(gun.global_rotation,
				target_rot + PI / 2, rot_speed * delta)


func _draw() -> void:
	draw_circle(Vector2.ZERO, detect_radius, DETECTOR_COLOR)


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if coll_radius:
		(coll_radius.shape as CircleShape2D).radius = detect_radius


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in targets:
		targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
