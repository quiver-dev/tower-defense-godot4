class_name Tank
extends ShootingEnemy


@onready var explosion := $Explosion as AnimatedSprite2D


# Override parent function
func apply_animation(anim_name: String) -> void:
	super(anim_name)
	
