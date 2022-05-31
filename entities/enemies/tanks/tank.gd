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


func shoot(_position: Vector2) -> void:
	can_shoot = false
	var bullet: Bullet = bullet_type.instantiate()
	bullet.start(muzzle.global_position,
			gun.rotation + randf_range(-bullet_spread, bullet_spread))
	bullet_container.add_child(bullet, true)
	firerate_timer.start(fire_rate)


# Checks if there are other tanks ahead
func is_raycast_colliding() -> bool:
	for raycast in [$LookAhead1, $LookAhead2]:
		if (raycast as RayCast2D).is_colliding() and \
				(raycast as RayCast2D).get_collider() is Tank:
			return true
	return false


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if detector_shape:
		detector_shape.radius = detect_radius


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
