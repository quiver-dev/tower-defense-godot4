class_name Helicopter
extends Enemy


@onready var shadow := $Shadow as AnimatedSprite2D
@onready var rotor := $Rotor as AnimatedSprite2D


func _physics_process(delta: float) -> void:
	super(delta)
	# Rotate based on current velocity
	shadow.global_rotation = _calculate_rot(sprite.global_rotation,
			velocity.angle(), rot_speed, delta)
	rotor.global_rotation = _calculate_rot(sprite.global_rotation,
			velocity.angle(), rot_speed, delta)
