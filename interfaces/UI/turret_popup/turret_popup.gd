extends CanvasLayer
# TODO: try using the new Popup class when they stabilize it. At the
# moment it seems broken, or at least there's no documentation to
# understand how to use it.


func _on_close_pressed() -> void:
	hide()


# For now, the Background node mimics the old "exclusive" Popup functionality:
# when clicking outside the popup panel, the popup closes.
func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hide()
