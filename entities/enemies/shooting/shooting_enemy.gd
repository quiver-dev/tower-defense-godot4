class_name ShootingEnemy
extends Enemy


var can_shoot_and_move := false  # set by certain states

@onready var shooter := $Shooter as Shooter


func _on_shooter_has_shot(reload_time: float) -> void:
	hud.update_reloadbar(reload_time)
