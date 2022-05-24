extends Motion


func update(_delta: float) -> void:
	_move()


func _on_navigation_agent_2d_target_reached() -> void:
	emit_signal("finished", "idle")
