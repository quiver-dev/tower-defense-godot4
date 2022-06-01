@tool
class_name Shooter
extends Node2D
# Class extended by those entities which can shoot, e.g. turrets or tanks.
# The scenes this script is attached to must have the nodes referenced by
# the @onready variables, otherwise the game will crash on purpose.


@export var detector_color: Color = Color(1, 0.22, 0.25, 0.25)  # for debug
@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float = 0.5
@export var rot_speed: float = 5.0
@export var bullet_type: PackedScene
@export var bullet_spread: float = 0.2

var targets: Array[Node2D]
var can_shoot := true

@onready var gun: Sprite2D = $Gun
@onready var muzzle: Position2D = $Gun/Muzzle
@onready var detector: Area2D = $Detector
@onready var detector_coll: CollisionShape2D = $Detector/CollisionShape2D
@onready var detector_shape := CircleShape2D.new()
@onready var bullet_container: Node = $BulletContainer
@onready var firerate_timer: Timer = $FireRateTimer


func _ready() -> void:
	# initialize detector's shape
	detector_shape.radius = detect_radius
	detector_coll.shape = detector_shape


func _physics_process(_delta: float) -> void:
	update()


func _draw() -> void:
	draw_circle(Vector2.ZERO, detect_radius, detector_color)


func shoot() -> void:
	can_shoot = false
	var bullet: Bullet = bullet_type.instantiate()
	bullet.start(muzzle.global_position,
			gun.rotation + randf_range(-bullet_spread, bullet_spread))
	bullet_container.add_child(bullet, true)
	firerate_timer.start(fire_rate)


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if detector_shape:
		detector_shape.radius = detect_radius


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
