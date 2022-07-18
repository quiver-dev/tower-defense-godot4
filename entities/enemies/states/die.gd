extends State


func enter() -> void:
	(owner as Enemy).stop()
#	set_physics_process(false)
	(owner as Enemy).collision.set_deferred("disabled", true)
	(owner as Enemy).apply_animation("die")


func on_animation_finished() -> void:
	(owner as Enemy).enemy_dead.emit()
	(owner as Enemy).queue_free()
