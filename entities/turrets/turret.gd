@tool
class_name Turret
extends CharacterBody2D


signal turret_disabled

const DETECTOR_COLOR := Color(1, 0.22, 0.25, 0.25)  # for debug purposes

@export_range(0, 100) var health: int = 10
@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float = 0.5
@export var rot_speed: float = 3.0
@export var bullet_type: PackedScene
@export var bullet_spread: float = 0.02

var targets: Array[Node2D]
var can_shoot := true

@onready var gun: Sprite2D = $Gun
@onready var coll_radius: CollisionShape2D = $Detector/CollisionShape2D
@onready var muzzle: Position2D = $Gun/Muzzle
@onready var bullet_container: Node = $BulletContainer
@onready var firerate_timer: Timer = $FireRateTimer


func _ready() -> void:
	(coll_radius.shape as CircleShape2D).radius = detect_radius


func _physics_process(delta: float) -> void:
	update()
	if targets:
		var target_pos: Vector2 = targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		gun.rotation = lerp_angle(gun.rotation, target_rot + PI / 2,
				rot_speed * delta)
		if can_shoot:
			shoot(targets.front().global_position)


func _draw() -> void:
	draw_circle(Vector2.ZERO, detect_radius, DETECTOR_COLOR)


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if coll_radius:
		(coll_radius.shape as CircleShape2D).radius = detect_radius


func shoot(_position: Vector2) -> void:
	can_shoot = false
	var bullet: Bullet = bullet_type.instantiate()
	bullet.start(muzzle.global_position, gun.rotation - PI / 2)
	bullet_container.add_child(bullet, true)
	firerate_timer.start(fire_rate)


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		emit_signal("turret_disabled")
		print("turret_disabled")


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true


# Detector's Area2D can only scan for enemies. See its collision mask.
func _on_detector_body_entered(body: Node2D) -> void:
	if not body in targets:
		targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
