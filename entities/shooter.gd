@tool
class_name Shooter
extends Node2D
# Class aggregated by those entities which can shoot, e.g. turrets or tanks.
# We are using component-based programming principles by leveraging Godot's
# node system to replace multiple inheritance, which is not supported by
# the engine.


@export var detector_color: Color = Color(1, 0.22, 0.25, 0.25)  # for debug
@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float = 0.5
@export var rot_speed: float = 5.0
@export var bullet_type: PackedScene
@export var bullet_spread: float = 0.2

var targets: Array[Node2D]
var can_shoot := true
var tween: Tween

@onready var gun := $Gun as Sprite2D
@onready var muzzle := $Gun/Muzzle as Position2D
@onready var detector := $Detector as Area2D
@onready var detector_coll := $Detector/CollisionShape2D as CollisionShape2D
@onready var detector_shape := CircleShape2D.new()
@onready var bullet_container := $BulletContainer as Node
@onready var firerate_timer := $FireRateTimer as Timer
@onready var reload_bar := $ReloadBar as TextureProgressBar


func _ready() -> void:
	# initialize detector's shape
	detector_shape.radius = detect_radius
	detector_coll.shape = detector_shape
	# initialize reload bar
	reload_bar.value = 0
	reload_bar.hide()


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
	# show reload time on HUD
	tween = get_tree().create_tween()
	tween.tween_callback(reload_bar.show)
	tween.tween_method(_update_bar, reload_bar.value, reload_bar.max_value,
			firerate_timer.wait_time)
	tween.tween_callback(reload_bar.hide)


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if detector_shape:
		detector_shape.radius = detect_radius


# Called by parent node when it gets freed: used to perform cleanup operations
func cleanup() -> void:
	tween.kill()


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true


func _update_bar(value) -> void:
	reload_bar.value = value
	if value > reload_bar.max_value * 0.0:
		reload_bar.self_modulate = Color("#ab2929") # red
	if value > reload_bar.max_value * 0.33:
		reload_bar.self_modulate = Color("#d2b82d") # yellow
	if value > reload_bar.max_value * 0.66:
		reload_bar.self_modulate = Color("#54722e") # green
	if value == reload_bar.max_value:
		reload_bar.value = reload_bar.min_value
