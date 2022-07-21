extends State


const FADE_OUT_DURATION := 0.25


func enter() -> void:
	(owner as Enemy).stop()
#	set_physics_process(false)
	(owner as Enemy).collision.set_deferred("disabled", true)
	(owner as Enemy).apply_animation("die")


func on_animation_finished() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property((owner as Enemy), "modulate:a", 0.0, FADE_OUT_DURATION)
	tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	(owner as Enemy).enemy_dead.emit()
	(owner as Enemy).queue_free()
