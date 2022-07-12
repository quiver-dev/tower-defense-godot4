@tool
class_name Shooter
extends Node2D
# Class aggregated by those entities which can shoot, e.g. turrets or tanks.
# We are using component-based programming principles by leveraging Godot's
# node system to replace multiple inheritance, which is not supported by
# the engine. This method is called "composition", or "aggregation".
# This scene supports multiple projectiles per shot: just set the projectile count
# parameter in the editor and it will spawn the corresponding number of
# muzzles under the Gun node. Then just tweak their position and projectiles
# will spawn from there.


signal has_shot(reload_time: float)

@export var detector_color: Color = Color(1, 0.22, 0.25, 0.25)  # for debug
@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float = 0.5
@export var rot_speed: float = 5.0
@export_range(1, 6) var projectile_count: int = 1:
	set = set_projectile_count
@export var projectile_type: PackedScene
@export var projectile_spread: float = 0.2
@export var projectile_speed: int = 1000
@export var projectile_damage: int = 10

var targets: Array[Node2D]
var can_shoot := true

@onready var gun := $Gun as AnimatedSprite2D
@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
@onready var detector := $Detector as Area2D
@onready var detector_coll := $Detector/CollisionShape2D as CollisionShape2D
@onready var detector_shape := CircleShape2D.new()
@onready var lookahead  := $LookAhead as RayCast2D
@onready var projectile_container := $ProjectileContainer as Node
@onready var firerate_timer := $FireRateTimer as Timer


func _ready() -> void:
	# initialize detector's shape
	detector_shape.radius = detect_radius
	detector_coll.shape = detector_shape
	# initialize raycast's length
	lookahead.target_position.x = detect_radius
	# init animations
	_play_animations("idle")


func _physics_process(delta: float) -> void:
	# update draw
	update()
	if not targets.is_empty():
		# handle the gun rotation
		var target_pos: Vector2 = targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		rotation = lerp_angle(rotation, target_rot, rot_speed * delta)


func _draw() -> void:
	draw_arc(Vector2.ZERO, detect_radius, 0, 2 * PI, 500, detector_color)


# Gets called by its parents. This way we have more control on when to shoot
func shoot() -> void:
	can_shoot = false
	for _muzzle in gun.get_children():
		var projectile: Projectile = projectile_type.instantiate()
		projectile.start(_muzzle.global_position,
				rotation + randf_range(-projectile_spread, projectile_spread),
				projectile_speed, projectile_damage)
		projectile_container.add_child(projectile, true)
		projectile.collision_mask = detector.collision_mask
	firerate_timer.start(fire_rate)
	# play animations
	_play_animations("shoot")
	# show reload time on HUD
	emit_signal("has_shot", firerate_timer.wait_time)


# Could be called by enemy states, e.g. to freeze the tank's reload time
# when hit.
func set_firerate_timer_paused(value: bool) -> void:
	firerate_timer.paused = value


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if detector_shape:
		detector_shape.radius = detect_radius
		lookahead.target_position.x = detect_radius


# WARN: because of https://github.com/godotengine/godot/issues/60168, I need
# to reference $Gun manually to make this setter work in inheriting classes
# when running on the editor.
func set_projectile_count(value: int) -> void:
	projectile_count = value
	var diff := value - $Gun.get_child_count()
	match signi(diff):
		1:
			for i in diff:
				var dup = $Gun/Muzzle.duplicate() as Position2D
				$Gun.add_child(dup, true)
				dup.owner = self
		-1:
			for i in abs(diff):
				$Gun.get_child(i + 1).queue_free()


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
	_play_animations("idle")


func _play_animations(anim_name: String) -> void:
	gun.frame = 0
	muzzle_flash.frame = 0
	gun.play(anim_name)
	muzzle_flash.play(anim_name)
