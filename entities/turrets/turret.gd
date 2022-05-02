class_name Turret
extends CharacterBody2D


const DETECTOR_COLOR := Color(1, 0.22, 0.25)

@export var detect_radius: int = 80
@export var fire_rate: float
@export var bullet_type: PackedScene

var targets := []
var can_shoot := true

@onready var coll_radius := $Detector/CollisionShape2D


func _ready() -> void:
	(coll_radius.shape as CircleShape2D).radius = detect_radius


func _physics_process(_delta: float) -> void:
	update()


func _draw() -> void:
	draw_circle(Vector2.ZERO, detect_radius, DETECTOR_COLOR)


func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true
