extends Motion


func enter() -> void:
	(owner as Enemy).apply_animation("move")


func update(_delta: float) -> void:
	_move()


func _on_navigation_agent_2d_target_reached() -> void:
	finished.emit("idle")
