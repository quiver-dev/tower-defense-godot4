@tool
class_name Shooter
extends Node2D
# Class aggregated by those entities which can shoot, e.g. turrets or tanks.
# We are using component-based programming principles by leveraging Godot's
# node system to replace multiple inheritance, which is not supported by
# the engine. This is called "composition", or "aggregation".
# This scene supports multiple projectiles per shot: just set the projectile count
# parameter in the editor and it will spawn the corresponding number of
# muzzles under the Gun node. Then just tweak their position and projectiles
# will spawn from there.


signal has_shot(reload_time: float)
signal projectile_instanced(type: Projectile)
signal anim_restarted(anim_name: String)  # used to sync animations

@export var detector_color: Color = Color(1, 0.22, 0.25, 0.25)  # for debug
@export var detect_radius: int = 200:
	set = set_detect_radius
@export var fire_rate: float = 0.5
@export var rot_speed: float = 5.0
@export_enum("Normal", "Homing") var shooting_mode: int
@export_range(1, 6) var projectile_count: int = 1:
	set = set_projectile_count
@export var projectile_type: PackedScene
@export var projectile_spread: float = 0.2
@export var projectile_speed: int = 1000
@export var projectile_damage: int = 10

var is_mouse_hovering := false  # used to draw detect radius, set by parent scene
var targets: Array[Node2D]
var can_shoot := true
var muzzle_idx := -1  # used in homing mode, otherwise stays negative

@onready var gun := $Gun as AnimatedSprite2D
@onready var muzzle_flash := $MuzzleFlash as AnimatedSprite2D
@onready var detector := $Detector as Area2D
@onready var detector_coll := $Detector/CollisionShape2D as CollisionShape2D
@onready var detector_shape := CircleShape2D.new()
@onready var lookahead := $LookAhead as RayCast2D
@onready var firerate_timer := $FireRateTimer as Timer


func _ready() -> void:
	if shooting_mode == 1:  # Homing
		muzzle_idx = 0
	# initialize detector's shape
	detector_shape.radius = detect_radius
	detector_coll.shape = detector_shape
	# initialize raycast's length and collision mask
	lookahead.target_position.x = detect_radius + 50
	lookahead.collision_mask = detector.collision_mask
	# init animations
	_play_animations("idle")


func _physics_process(delta: float) -> void:
	# update draw
	queue_redraw()
	if not targets.is_empty():
		# handle the gun rotation
		var target_pos: Vector2 = targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		rotation = lerp_angle(rotation, target_rot, rot_speed * delta)


func _draw() -> void:
	draw_circle(Vector2.ZERO, detect_radius if is_mouse_hovering else 0,
			detector_color)


# Gets called by its parents, so that we have more control over when to shoot
func shoot() -> void:
	can_shoot = false
	if shooting_mode == 0:  # Normal
		for _muzzle in gun.get_children():
			_instance_projectile(_muzzle.global_position)
		_play_animations("shoot")
	else:  # Homing
		var muzzle_pos := (gun.get_child(muzzle_idx) as Marker2D).global_position
		_instance_projectile(muzzle_pos, targets.front())
		muzzle_idx = Global.wrap_index(muzzle_idx + 1, projectile_count)
		muzzle_flash.global_position = muzzle_pos
		_play_animations("shoot_%s" % ["b" if muzzle_idx == 0 else "a"])
	# show reload time on HUD
	firerate_timer.start(fire_rate)
	has_shot.emit(firerate_timer.wait_time)


func explode() -> void:
	# stop processing and prevent from shooting
	set_physics_process(false)
	can_shoot = false
	firerate_timer.stop()
	# play animation
	_play_animations("explode")


# Could be called by enemy states, e.g. to freeze the tank's reload time
# when hit.
func set_firerate_timer_paused(value: bool) -> void:
	firerate_timer.paused = value


func set_detect_radius(value: int) -> void:
	detect_radius = value
	if is_instance_valid(detector_shape):
		detector_shape.radius = detect_radius
		lookahead.target_position.x = detect_radius


func set_projectile_count(value: int) -> void:
	projectile_count = value
	var _gun := get_node("Gun")
	var diff := value - _gun.get_child_count()
	match signi(diff):
		1:
			for i in diff:
				var dup = _gun.get_node("Muzzle").duplicate() as Marker2D
				_gun.add_child(dup, true)
				dup.owner = self
		-1:
			for i in abs(diff):
				_gun.get_child(-1).queue_free()


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true


func _instance_projectile(_position: Vector2, target=null) -> void:
	var projectile: Projectile = projectile_type.instantiate()
	projectile.start(_position,
			rotation + randf_range(-projectile_spread, projectile_spread),
			projectile_speed, projectile_damage, target)
	projectile.collision_mask = detector.collision_mask
	projectile_instanced.emit(projectile)


func _play_animations(anim_name: String) -> void:
	gun.play(anim_name)
	muzzle_flash.play(anim_name)
	anim_restarted.emit(anim_name)


func _on_parent_mouse_entered() -> void:
	is_mouse_hovering = true


func _on_parent_mouse_exited() -> void:
	is_mouse_hovering = false


func _on_gun_animation_finished() -> void:
	if gun.animation.contains("shoot"):
		_play_animations("idle")


# We need a slightly different logic for looping animations, as we want
# to keep them looping if they still have targets
func _on_gun_animation_looped() -> void:
	if gun.animation.contains("shoot") and targets.is_empty():
		_play_animations("idle")


# We only write on the targets array, then each parent entity will
# take care of switching the state
func _on_detector_area_entered(area: Area2D) -> void:
	if not area in targets:
		targets.append(area)


func _on_detector_area_exited(area: Area2D) -> void:
	if area in targets:
		targets.erase(area)


func _on_detector_body_entered(body: Node2D) -> void:
	if not body in targets:
		targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
