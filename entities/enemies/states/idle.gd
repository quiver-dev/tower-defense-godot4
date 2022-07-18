extends State


func enter() -> void:
	(owner as Enemy).stop()
	(owner as Enemy).apply_animation("idle")


# WARN: for debugging purposes. To be removed?
func handle_input(event: InputEvent) -> InputEvent:
	if event is InputEventMouseButton and event.is_pressed() and \
			event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos := (owner as Enemy).get_global_mouse_position()
		(owner as Enemy).move_to(click_pos)
		emit_signal("finished", "move")
	return super.handle_input(event)
