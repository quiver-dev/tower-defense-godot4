class_name Tank
extends Enemy


@onready var shooter := $Shooter as Shooter
@onready var explosion := $Explosion as AnimatedSprite2D


func _on_shooter_has_shot(reload_time: float) -> void:
	hud.update_reloadbar(reload_time)
