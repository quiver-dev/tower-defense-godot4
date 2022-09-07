class_name Helicopter
extends ShootingEnemy


@onready var shadow := $Shadow as AnimatedSprite2D
@onready var rotor := $Rotor as AnimatedSprite2D


func _physics_process(delta: float) -> void:
	super(delta)
	# Rotate based on current velocity
	sprite.global_rotation = shooter.rotation
	shadow.global_rotation = sprite.global_rotation
	rotor.global_rotation = sprite.global_rotation


func apply_animation(anim_name: String) -> void:
	super(anim_name)
	for animated_sprite in [shadow, rotor]:
		if is_instance_valid(animated_sprite) and \
				(animated_sprite as AnimatedSprite2D).frames.has_animation(anim_name):
			(animated_sprite as AnimatedSprite2D).play(anim_name)
