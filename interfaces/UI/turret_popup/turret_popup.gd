extends CanvasLayer
# TODO: try using the new Popup class when they stabilize it. At the
# moment it seems broken, or at least there's no documentation to
# understand how to use it.


signal turret_requested(type: String)


func _on_close_pressed() -> void:
	hide()


# For now, the Background node mimics the old "exclusive" Popup functionality:
# when clicking outside the popup panel, the popup closes.
func _on_background_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			hide()


# Note that you can pass custom arguments to a signal by enabling advanced 
# settings  when connecting a signal to a method using the editor.
# In this case we are passing the turret type based on which button is pressed.
func _on_button_pressed(type: String) -> void:
	# TODO: define a consistent way to pass turret data to parent scenes
	emit_signal("turret_requested", type)
	hide()
