extends State


func enter() -> void:
	(owner as Enemy).stop()
	(owner as Enemy).apply_animation("idle")
