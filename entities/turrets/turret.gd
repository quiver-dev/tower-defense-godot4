class_name Turret
extends CharacterBody2D


signal turret_disabled

@export_range(0, 100) var health: int = 100

@onready var shooter := $Shooter as Shooter
@onready var hud := $EntityHUD as EntityHud


func _ready() -> void:
	# hide non-relevant HUD parts
	hud.state_label.hide()


func _physics_process(_delta: float) -> void:
	if shooter.targets:
		if shooter.can_shoot:
			shooter.shoot()


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	hud.healthbar.value = health
	if health == 0:
		_explode()


func _explode() -> void:
	# TODO: add all necessary operations: e.g. play animation
	emit_signal("turret_disabled")
	queue_free()


# Detector's Area2D can only scan for enemies. See its collision mask.
func _on_detector_body_entered(body: Node2D) -> void:
	if not body in shooter.targets:
		shooter.targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in shooter.targets:
		shooter.targets.erase(body)


func _on_shooter_has_shot(reload_time: float) -> void:
	hud.update_reloadbar(reload_time)
