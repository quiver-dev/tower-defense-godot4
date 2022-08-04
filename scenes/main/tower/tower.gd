class_name Objective
extends Area2D


signal initialized(max_health: int)
signal health_changed(cur_health: int)
signal destroyed

# TODO: this could probably be an Enemy parameter: let that scene check damage
const DEFAULT_DAMAGE := 10  # default damage dealt by enemies

@export_range(0, 1000) var health: int = 500

@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var anim_sprite := $AnimatedSprite as AnimatedSprite2D
@onready var explosion := $Explosion as AnimatedSprite2D


func _ready() -> void:
	initialized.emit(health)


func take_damage(damage: int) -> void:
	health = max(0, health - damage)
	if health == 0:
		collision.set_deferred("disabled", true)
		anim_sprite.play("die")
		explosion.play("tower")
	else:
		health_changed.emit(health)


func _on_objective_body_entered(body: Node2D) -> void:
	if body is Enemy:
		take_damage(DEFAULT_DAMAGE)
		# WARN: this won't emit the enemy_dead signal
		(body as Enemy).queue_free()


func _on_animated_sprite_animation_finished() -> void:
	destroyed.emit()
