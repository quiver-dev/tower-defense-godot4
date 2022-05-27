class_name Tank
extends Enemy


@export var turret_speed: float = 3.0

var targets: Array[Node2D]

@onready var turret: Sprite2D = $Turret


func _ready() -> void:
	# WARN: this is a workaround, see https://github.com/godotengine/godot/issues/60168
	super._ready()


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	turret.global_rotation = _calculate_rot(turret.global_rotation,
			turret_speed, delta) if targets.is_empty() else 0.0
