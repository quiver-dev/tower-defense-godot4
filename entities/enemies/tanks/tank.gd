class_name Tank
extends Enemy


@onready var shooter := $Shooter as Shooter
@onready var explosion := $Explosion as AnimatedSprite2D


func _ready() -> void:
	# WARN: this is a workaround, see https://github.com/godotengine/godot/issues/60168
	super()


func _on_shooter_has_shot(reload_time: float) -> void:
	hud.update_reloadbar(reload_time)
