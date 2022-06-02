class_name Turret
extends CharacterBody2D


signal turret_disabled

@export_range(0, 100) var health: int = 100

@onready var shooter := $Shooter as Shooter


func _physics_process(delta: float) -> void:
	if shooter.targets:
		var target_pos: Vector2 = shooter.targets.front().global_position
		var target_rot: float = global_position.direction_to(target_pos).angle()
		shooter.gun.rotation = lerp_angle(shooter.gun.rotation,
				target_rot, shooter.rot_speed * delta)
		if shooter.can_shoot:
			shooter.shoot()


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		_explode()


func _explode() -> void:
	# TODO: add all necessary operations: e.g. play animation
	shooter.cleanup()
	emit_signal("turret_disabled")
	queue_free()


# Detector's Area2D can only scan for enemies. See its collision mask.
func _on_detector_body_entered(body: Node2D) -> void:
	if not body in shooter.targets:
		shooter.targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in shooter.targets:
		shooter.targets.erase(body)
