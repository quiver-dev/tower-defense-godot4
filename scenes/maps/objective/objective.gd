class_name Objective
extends Area2D


signal initialized(max_health: int)
signal health_changed(cur_health: int)
signal destroyed

@export_range(0, 1000) var health: int = 500:
	set = set_health

@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var anim_sprite := $AnimatedSprite as AnimatedSprite2D
@onready var explosion := $Explosion as AnimatedSprite2D


func _ready() -> void:
	initialized.emit(health)


func set_health(value: int) -> void:
	health = max(0, value)
	if health == 0:
		collision.set_deferred("disabled", true)
		anim_sprite.play("die")
		explosion.play("objective")
	else:
		health_changed.emit(health)


func _on_objective_body_entered(body: Node2D) -> void:
	if body is Enemy:
		health -= (body as Enemy).objective_damage
		# force enemy death in this case
		(body as Enemy).dead.emit()
		(body as Enemy).queue_free()


func _on_animated_sprite_animation_finished() -> void:
	destroyed.emit()
