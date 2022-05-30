class_name Tank
extends Enemy


@export var turret_speed: float = 3.0
@export var detect_radius: int = 150:
	set = set_detect_radius
@export var fire_rate: float = 2.5
@export var bullet_type: PackedScene
@export var bullet_spread: float = 0.2

var targets: Array[Node2D]
var can_shoot := true

@onready var gun: Sprite2D = $Gun
@onready var muzzle: Position2D = $Gun/Muzzle
@onready var bullet_container: Node = $BulletContainer
@onready var firerate_timer: Timer = $FireRateTimer
@onready var detector_coll: CollisionShape2D = $Detector/CollisionShape2D
@onready var detector_shape := CircleShape2D.new()


func _ready() -> void:
	# WARN: this is a workaround, see https://github.com/godotengine/godot/issues/60168
	super._ready()
	# initialize detector's shape
	detector_shape.radius = detect_radius
	detector_coll.shape = detector_shape


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if targets:
		var target_pos: Vector2 = targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		gun.rotation = _calculate_rot(gun.rotation, target_rot + PI / 2,
				rot_speed, delta)
		if can_shoot:
			shoot(targets.front().global_position)
	else:
		gun.rotation = _calculate_rot(gun.rotation, velocity.angle(),
				turret_speed, delta)


func shoot(_position: Vector2) -> void:
	can_shoot = false
	var bullet: Bullet = bullet_type.instantiate()
	bullet.start(muzzle.global_position,
			gun.rotation - PI / 2 + randf_range(-bullet_spread, bullet_spread))
	bullet_container.add_child(bullet, true)
	firerate_timer.start(fire_rate)


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if detector_shape:
		detector_shape.radius = detect_radius


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
