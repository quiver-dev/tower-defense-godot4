class_name Turret
extends CharacterBody2D


signal turret_disabled

const FADE_OUT_DURATION := 0.25

@export_range(1, 500) var health: int = 100:
	set = set_health

# This works as long as all turrets are a single child of each turret slot,
# i.e. their name will always be "SingleTurret" or "MissileTurret", etc.
var type: String:
	get: return String(name).trim_suffix("Turret").to_lower()

@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var shooter := $Shooter as Shooter
@onready var explosion := $Explosion as AnimatedSprite2D
@onready var hud := $UI/EntityHUD as EntityHud


func _ready() -> void:
	# initialize HUD
	hud.state_label.hide()
	hud.healthbar.max_value = health
	hud.healthbar.value = health


func _physics_process(_delta: float) -> void:
	if shooter.targets:
		if shooter.can_shoot and shooter.lookahead.is_colliding():
			shooter.shoot()


# Called by the UI: gives some value back based on current health percentage
func remove() -> void:
	var health_perc: float = hud.healthbar.value / hud.healthbar.max_value
	var money_returned := int(Global.turret_prices[type] * health_perc / 2)
	Global.money += money_returned
	queue_free()


# Called by the UI: returns false if there isn't enough money to fix the turret
func repair() -> bool:
	var missing_health_perc: float = 1.0 - \
			(hud.healthbar.value / hud.healthbar.max_value)
	var money_needed := int(Global.turret_prices[type] * missing_health_perc)
	var can_repair := Global.money >= money_needed
	if can_repair:
		Global.money -= money_needed
		health = int(hud.healthbar.max_value)
	return can_repair


func set_health(value: int) -> void:
	health = max(0, value)
	if is_instance_valid(hud):
		hud.healthbar.value = health
	if health == 0:
		collision.set_deferred("disabled", true)
		shooter.explode()
		explosion.play("default")
		turret_disabled.emit()


func _on_gun_animation_finished() -> void:
	# triggered by shooter.explode()
	if shooter.gun.animation == "explode":
		var tween := get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0.0, FADE_OUT_DURATION)
		tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	queue_free()


# Detector's Area2D can only detect certain enemies. See its collision mask.
func _on_detector_body_entered(body: Node2D) -> void:
	if not body in shooter.targets:
		shooter.targets.append(body)


func _on_detector_body_exited(body: Node2D) -> void:
	if body in shooter.targets:
		shooter.targets.erase(body)


func _on_shooter_has_shot(reload_time: float) -> void:
	hud.update_reloadbar(reload_time)
